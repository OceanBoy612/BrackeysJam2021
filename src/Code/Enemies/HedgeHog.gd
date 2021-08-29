extends "res://Code/Enemies/Enemy.gd"


signal attacked
onready var quill_tscn = preload("res://Code/Bullets/QuillBullet.tscn")

func _ready():
	set_physics_process(false)
	$Sprite.play("Spawn")
	yield($Sprite, "animation_finished")
	$Sprite.play("Walk")
	set_physics_process(true)


func _on_AttackTimer_timeout():
	print("HIII")
	var quill = quill_tscn.instance()
	quill.global_position = $QuillSpawn.global_position + (move_dir * 18)
	quill.set_as_toplevel(true)
	quill.rotate(move_dir.angle())
	quill.hurt_player()
#	quill.damage = 1.0
	get_parent().add_child(quill)
