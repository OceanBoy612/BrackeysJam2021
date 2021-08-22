extends KinematicBody2D
class_name Player


signal moved
signal shot
signal picked_up_item
signal reloaded_deck


export var speed: int = 100
var time_since_last_shot: float = OS.get_system_time_secs() - 1000
export var reload_time: float = 1.0


var aiming_dir = Vector2(1,0)
var move_dir = Vector2(0,0)

var draw_pile = []
var discard_pile = []


func _ready():
	Globals.player = self


func _physics_process(delta):
	aiming_dir = get_dir_to_mouse()
	update_aimer_position()
	
	move_dir = get_input_dir()
	move_and_slide(move_dir * speed)
	
	if move_dir.is_equal_approx(Vector2()):
		emit_signal("moved")


func _input(event):
	if can_shoot():
		shoot()


func can_shoot():
	return Input.is_action_pressed("ui_accept") and OS.get_system_time_secs() - time_since_last_shot > reload_time


func shoot():
	var current_card = draw_pile.pop_front()
	# DO STUFF
	print("Shoot")
	discard_pile.push_back(current_card)
	
	if draw_pile.empty():
		shuffle()
		
	time_since_last_shot = OS.get_system_time_secs()
	
	emit_signal("shot")


func shuffle():
	draw_pile = discard_pile
	draw_pile.shuffle()
	discard_pile = []


func get_input_dir() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()


func get_dir_to_mouse() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()


func update_aimer_position():
	$Aimer.position = $Aimer.position.rotated($Aimer.position.angle_to(aiming_dir))
	$Aimer.look_at(global_position * aiming_dir * 100)
	
	if $Aimer.position.angle() < - PI / 2 or $Aimer.position.angle() > PI / 2:
		$Aimer.scale.y = -1
	else:
		$Aimer.scale.y = 1












