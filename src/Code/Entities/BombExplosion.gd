extends Area2D


export(int, 0, 10, 1) var damage: int = 1


func _ready():
	$Sprite.play("Idle")


func init(bullet):
#	damage = bullet.damage
	pass


func _on_BombExplosion_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
	


func _on_Sprite_animation_finished():
	queue_free()
