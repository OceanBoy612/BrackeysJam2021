extends "res://Code/Enemies/Enemy.gd"


func _ready():
	set_physics_process(false)
	$Sprite.play("Spawn")
	yield($Sprite, "animation_finished")
	$Sprite.play("Walk")
	set_physics_process(true)

