extends KinematicBody2D


signal moved


export var speed = 250


func _physics_process(delta):
	var move_dir = get_dir_to_player()
	move_and_slide(move_dir * speed)





func get_dir_to_player() -> Vector2:
	return (Globals.player.global_position - global_position).normalized()


