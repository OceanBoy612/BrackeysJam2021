extends KinematicBody2D


export var speed = 300

func _physics_process(delta):
	move_and_slide(Vector2(1,0).rotated(rotation) * speed)
