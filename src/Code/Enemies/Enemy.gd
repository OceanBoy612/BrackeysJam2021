extends KinematicBody2D

signal moved
signal died

export var speed = 250
export var health: float = 1.0
var move_dir = Vector2(1,0)

func _physics_process(delta):
	if not Globals.player:
		return
	enemy_process(delta)


func enemy_process(_delta):
	move_dir = get_dir_to_player()
	var _vel = move_and_slide(move_dir * speed)
	emit_signal("moved")


func damage(amt: float):
	health -= amt
	if health <= 0:
		emit_signal("died")
		queue_free()


### Helper functions ###
func get_dir_to_player() -> Vector2:
	return (Globals.player.global_position - global_position).normalized()
