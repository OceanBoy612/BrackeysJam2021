extends "res://Code/World.gd"


onready var width = ProjectSettings.get_setting("display/window/size/width")
onready var height = ProjectSettings.get_setting("display/window/size/height")
var cell_size = 16

func _ready():
	player.connect("screen_exited", self, "on_screen_exited")
	for spawner in $Spawners.get_children():
		spawner.connect("all_enemies_killed", self, "on_all_enemies_killed")
	on_screen_exited()


func on_all_enemies_killed():
	get_tree().call_group("fences", "open")


func on_screen_exited():
	# detect what side the player left the screen
	var side: String = get_side_player_left_screen_on()
	# move the camera in that direction
	move_camera(side)
	# enable the spawners in that 'room'
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().call_group("wave_spawners", "spawn_wave")
	yield(get_tree().create_timer(0.1), "timeout")
	if get_tree().get_nodes_in_group("spawned_enemies").size() > 0:
		get_tree().call_group("fences", "close")
	else:
		get_tree().call_group("fences", "open")
		


func move_camera(side: String):
	match side:
		"right":
			cam.position.x += width - cell_size
		"left":
			cam.position.x -= width - cell_size
		"bot":
			cam.position.y += height - cell_size
		"top":
			cam.position.y -= height - cell_size
		_:
			push_warning("No side found, not moving camera")


func get_side_player_left_screen_on() -> String:
	var left_bound = cam.position.x - width / 2
	var right_bound = cam.position.x + width / 2
	var top_bound = cam.position.y - height / 2
	var bot_bound = cam.position.y + height / 2
	if player.position.x > right_bound:
		return "right"
	elif player.position.x < left_bound:
		return "left"
	elif player.position.y > bot_bound:
		return "bot"
	elif player.position.y < top_bound:
		return "top"
	else:
		return ""
