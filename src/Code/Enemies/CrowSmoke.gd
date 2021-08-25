extends AnimatedSprite



func _ready():
	play("Idle")




func _on_CrowSmoke_animation_finished():
	queue_free()
