extends "res://Code/Enemies/Enemy.gd"


"""

Crow charges at the players position like a torpedo 
if it hits something or reaches the end of its travel 
then it stops and lands.

It will hop roughly away from the player in between reloading

"""

signal state_changed
signal charged
signal landed


export var charge_speed_multiplier: float = 3.0
export(float, 0.7, 1.0, 0.01) var landing_speed_decay: float = 0.9
#export(String, "clockwise", "counter_clockwise", "random") var strafe_dir = "random" # not implemented


var distance_to_travel: float
var distance_traveled: float


var state setget set_state
enum {
	CHARGING,
	WANDERING,
	PREPARE,
	LANDING,
}

func _ready():
	connect("died", self, "reset_sprite_angle")
	set_state(WANDERING)


func reset_sprite_angle():
	$Sprite.rotation = 0


func enemy_process(delta):
	match state:
		CHARGING:
			charge(delta)
		WANDERING:
			wander()
		PREPARE:
			prepare()
		LANDING:
			landing()


func landing():
	move_dir *= 0.9
	var _vel = move_and_slide(move_dir * speed)
	emit_signal("moved")
	pass
func prepare():
	pass


func wander():
	move_dir = get_dir_to_player() * -1
	var _vel = move_and_slide(move_dir * speed)
	emit_signal("moved")
	
	if $WanderTimer.is_stopped():
		end_wander()
	pass


func charge(delta):
#	Globals.player.global_position
	var _vel = move_and_slide(move_dir * speed * charge_speed_multiplier)
	emit_signal("moved")
	
	distance_traveled += speed * delta * charge_speed_multiplier
	if distance_traveled > distance_to_travel:
		end_charge()
		return
	
	for i in range(get_slide_count()):
		var col: KinematicCollision2D = get_slide_collision(i)
		if col.collider is TileMap:
			end_charge()
			return
		elif col.collider is Player: # .has_method("damage"):
			col.collider.damage(damage)
			end_charge()
			return
		


func end_charge():
	set_state(LANDING)

func end_wander():
	set_state(PREPARE)
	


func set_state(new_state):
	state = new_state
	match new_state:
		CHARGING:
			move_dir = get_dir_to_player()
			distance_to_travel = get_distance_to_player()
			distance_traveled = 0
			$Sprite.play("Air")
			$Sprite.rotation = move_dir.angle() # rotate the sprite in the direction of movement
			move_to_ghost_layer(true)
		WANDERING:
			$WanderTimer.start()
			$Sprite.play("Walk")
			move_to_ghost_layer(false)
		LANDING:
			$Sprite.rotation = 0
			$Sprite.play("Land")
		PREPARE:
			$Sprite.play("Charge")
	emit_signal("state_changed")
	

var smoke_tscn = preload("res://Code/Enemies/CrowSmoke.tscn")
func _on_Sprite_animation_finished():
	match $Sprite.animation:
		"Charge":
			set_state(CHARGING)
			$Sprite.play("Air")
			var smoke = smoke_tscn.instance()
			smoke.global_position = $SmokeSpawn.global_position
			get_parent().add_child(smoke)
		"Land":
			set_state(WANDERING)
			$Sprite.play("Walk")
		"Air":
			pass
		"Walk":
			pass
