extends KinematicBody2D
class_name EntityBase

signal moved
signal picked_up


export var speed = 250
enum Modes {
	ItemMode,
	EntityMode,
	BulletMode,
}
export(Modes) var mode = Modes.EntityMode setget set_mode
export var item_name = "Base"


var move_dir = Vector2(1,0)


func _ready():
	set_mode(mode)


func _physics_process(delta):
	if not Globals.player:
		return
	
	match mode:
		Modes.ItemMode:
			item_process(delta)
		Modes.EntityMode:
			entity_process(delta)
		Modes.BulletMode:
			bullet_process(delta)


func item_process(delta):
	# Do nothing: See set_mode
	pass


func bullet_process(delta):
	move_and_slide(Vector2(1,0).rotated(rotation) * speed)
	pass


func entity_process(delta):
	move_dir = get_dir_to_player()
	move_and_slide(move_dir * speed)


### Helper functions ###

func set_mode(new_mode) -> void:
	match mode: # Old mode Clean Up
		Modes.ItemMode:
			$Shape.set_deferred("disabled", false)
			$PlayerDetector/Shape.set_deferred("disabled", true)
		Modes.EntityMode:
			pass
		Modes.BulletMode:
			call_deferred("set_collision_mask_bit", 1, true)
		
	match new_mode: # Enter a new mode
		Modes.ItemMode:
			$PlayerDetector/Shape.set_deferred("disabled", false)
			$Shape.set_deferred("disabled", true)
		Modes.EntityMode:
			pass
		Modes.BulletMode:
			$PlayerDetector/Shape.set_deferred("disabled", true)
			call_deferred("set_collision_mask_bit", 1, false) # don't hit the player
	
	mode = new_mode


func get_dir_to_player() -> Vector2:
	return (Globals.player.global_position - global_position).normalized()


### Signal Methods ###

func _on_PlayerDetector_body_entered(body):
	# item was picked up
	if body.has_method("pickup_item"):
		print(item_name)
		body.pickup_item(item_name)
		emit_signal("picked_up")
		queue_free()
