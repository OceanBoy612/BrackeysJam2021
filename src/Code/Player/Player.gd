extends KinematicBody2D
class_name Player


signal moved
signal stopped
signal shot
signal picked_up_item
signal charged
signal shuffled_deck


export var speed: int = 100
var time_since_last_shot: float = OS.get_system_time_msecs() - 1000
export(int, 0, 4000, 50) var reload_time_msecs: int = 1000


var aiming_dir = Vector2(1,0)
var move_dir = Vector2(0,0)

var draw_pile = [] # Array of Strings - use Globals to access and load
var discard_pile = []


func _ready():
	Globals.player = self
	$Aimer/Blunderbuss.connect("shot", self, "shoot")


func _physics_process(_delta):
	aiming_dir = get_dir_to_mouse()
	update_aimer_position()
	
	var old_move_dir = move_dir
	move_dir = get_input_dir()
	var _vel = move_and_slide(move_dir * speed)
	
	if not move_dir.is_equal_approx(Vector2()):
		emit_signal("moved")
	else:
		emit_signal("stopped")
		
#	if can_shoot(): # full auto
#		shoot()
	
	if Input.is_action_pressed("shoot"):
		charge_gun()
	elif Input.is_action_just_released("shoot"):
		shoot_gun()
	
	update() # debugging


#func _input(event):
#	if event.is_action_pressed("shoot"):
#		charge_gun()
#	elif event.is_action_released("shoot"):
#		shoot_gun()





func shoot_gun():
	$Aimer/Blunderbuss.shoot()


func charge_gun():
	emit_signal("charged")
	$Aimer/Blunderbuss.windup()


func can_shoot():
	return Input.is_action_pressed("shoot") and OS.get_system_time_msecs() - time_since_last_shot > reload_time_msecs


func shoot():
#	print("Shoot")
	if draw_pile.empty():
		shuffle()
	
	var current_card_name = draw_pile.pop_front()
	if not current_card_name in Globals.items:
		push_error("Card not in Globals! %s" % current_card_name)
		return
	
	# instance from Globals
	var bullet = Globals.items[current_card_name].instance()
	bullet.position = position
	bullet.rotate($Aimer.rotation)
	get_parent().add_child(bullet)

	discard_pile.push_back(current_card_name)

	time_since_last_shot = OS.get_system_time_msecs()

	emit_signal("shot")


func shuffle():
	draw_pile = discard_pile
	draw_pile.shuffle()
	discard_pile = []
	$Aimer/Blunderbuss.reload()
	emit_signal("shuffled_deck")


func get_input_dir() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()


func get_dir_to_mouse() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()


func update_aimer_position():
	$Aimer.position = $Aimer.position.rotated($Aimer.position.angle_to(aiming_dir))
	$Aimer.look_at(global_position + aiming_dir * 100)
	
	if $Aimer.position.angle() < - PI / 2 or $Aimer.position.angle() > PI / 2:
		$Aimer.scale.y = -1
	else:
		$Aimer.scale.y = 1


func pickup_item(item: String):
	print("Picked up item, ", item)
	discard_pile.append(item)
	print(discard_pile)
	emit_signal("picked_up_item")


func _draw():
	draw_line(Vector2(), aiming_dir * 100, Color("#00ff00"), 1.5)




