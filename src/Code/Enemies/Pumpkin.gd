extends "res://Code/Enemies/Enemy.gd"


signal attacked


var attack_dist = 20
var attacking = false


func enemy_process(delta):
	if attacking:
		return
	
	var dist = get_distance_to_player()
	if dist < attack_dist:
		attack()
	else:
		.enemy_process(delta)
		
	
func attack():
	attacking = true
	$Sprite.play("Attack")
	$AttackArea/CollisionShape2D.disabled = false
	yield($Sprite, "animation_finished")
	attacking = false
	$Sprite.play("Walk")
	$AttackArea/CollisionShape2D.disabled = true
	


func _on_AttackArea_body_entered(body):
	if body is Player:
		body.damage(damage)
		$AttackArea/CollisionShape2D.set_deferred("disabled", true)
		
