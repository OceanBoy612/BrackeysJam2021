extends "res://Code/Enemies/Enemy.gd"


var strafing_left
onready var kernal_tscn = preload("res://Code/Bullets/KernalBullet.tscn")


func _ready():
	$ChangeDirections.wait_time *= rand_range(0.9, 1.1)


func enemy_process(_delta):
	move_dir = get_dir_to_player()
	var ang = -PI / 2 if strafing_left else PI / 2
	move_dir = move_dir.rotated(ang*0.85)
	if hitstun == 0:
		var _vel = move_and_slide(move_dir * speed)
	else:
		var _vel = move_and_slide(knockback)
	if hitstun > 0:
		 hitstun -= 1
	emit_signal("moved")


func _on_ChangeDirections_timeout():
	strafing_left = not strafing_left


func _on_AttackTimer_timeout():
	if dead:
		$AttackTimer.stop()
		return
	
	var kernal = kernal_tscn.instance()
	kernal.global_position = $KernalSpawn.global_position + (move_dir * 25)
	kernal.set_as_toplevel(true)
	kernal.rotate(get_dir_to_player().angle())
	kernal.hurt_player()
#	kernal.damage = 1.0
	get_parent().add_child(kernal)
	pass # Replace with function body.
