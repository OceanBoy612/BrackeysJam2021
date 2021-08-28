extends "res://Code/World.gd"


onready var width = ProjectSettings.get_setting("display/window/size/width")
onready var height = ProjectSettings.get_setting("display/window/size/height")


func _ready():
	player.connect("screen_exited", self, "on_screen_exited")
	on_screen_exited()


func on_screen_exited():
	# detect what side the player left the screen
	var side: String = get_side_player_left_screen_on()
	# move the camera in that direction
	move_camera(side)
	# enable the spawners in that 'room'
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().call_group("wave_spawners", "spawn_wave")


func move_camera(side: String):
	match side:
		"right":
			cam.position.x += width
		"left":
			cam.position.x -= width
		"bot":
			cam.position.y += height
		"top":
			cam.position.y -= height
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
