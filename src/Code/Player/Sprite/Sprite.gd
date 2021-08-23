extends AnimatedSprite


func _physics_process(_delta):
	var player = get_parent()
	
	if player.move_dir == Vector2.ZERO:
		stop()
	else:
		play("Walk")
	
	if player.aiming_dir.x > 0:
		flip_h = false
	else:
		flip_h = true
