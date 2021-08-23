extends KinematicBody2D

signal moved


export var speed = 250
var move_dir = Vector2(1,0)


func _physics_process(delta):
	if not Globals.player:
		return
	enemy_process(delta)


func enemy_process(delta):
	move_dir = get_dir_to_player()
	move_and_slide(move_dir * speed)


### Helper functions ###
func get_dir_to_player() -> Vector2:
	return (Globals.player.global_position - global_position).normalized()
