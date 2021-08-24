extends AnimatedSprite


func _physics_process(delta):
	global_position = get_global_mouse_position()


func _on_Blunderbuss_charged():
	play("Charging")


func _on_Blunderbuss_fired():
	play("Fire")


func _on_Blunderbuss_idled():
	play("Idle")


func _on_Blunderbuss_wound_up():
	play("Wind up")
