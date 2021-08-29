extends StaticBody2D


var is_open = false


func _ready():
	add_to_group("fences")


func open():
#	print("open")
	if not $VisibilityNotifier2D.is_on_screen():
		return
	if is_open:
		return
	
	$Sprite.play("Open")
	yield($Sprite, "animation_finished")
	$Shape.set_deferred("disabled", true)
	is_open = true


func close():
#	print("close1")
	if not $VisibilityNotifier2D.is_on_screen():
		return
#	print("close2")
	if not is_open:
		return
#	print("close3")
	
	$Sprite.play("Close")
	yield($Sprite, "animation_finished")
	$Shape.set_deferred("disabled", false)
	is_open = false
