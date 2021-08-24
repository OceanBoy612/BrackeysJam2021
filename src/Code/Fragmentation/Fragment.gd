extends Node2D


var text: Texture


func _ready():
	for child in get_children():
		if child is Sprite:
			child.texture = text
	
	$AnimationPlayer.play("fragment2")

