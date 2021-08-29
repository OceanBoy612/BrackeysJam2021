extends Node2D


var text: Texture


func _ready():
	for child in get_children():
		if child is Sprite:
			child.texture = text
	
	$BreakSound.play()
	$AnimationPlayer.play("fragment2")
	yield($BreakSound, "finished")
	queue_free()


func init(text: Texture, sound: AudioStream):
	for child in get_children():
		if child is Sprite:
			child.texture = text
	
	$BreakSound.stream = sound
	
