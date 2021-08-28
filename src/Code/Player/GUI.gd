extends Control


onready var player: Player = get_parent().get_parent() as Player



func _ready():
	player.connect("hit", self, "on_player_hit")


func on_player_hit():
#	for lifeicon in $HBoxContainer.get_children():
	for i in range($HBoxContainer.get_child_count()):
		var lifeicon = $HBoxContainer.get_child(i)
		var sprite = lifeicon.get_child(0) as AnimatedSprite
		if i+1 < player.health:
			match sprite.animation:
				"Idle":
					pass # do nothing
				"Idle off":
					heal(sprite)
		elif i+1 >= player.health:
			match sprite.animation:
				"Idle":
					hurt(sprite)
				"Idle off":
					pass
		

func heal(sprite: AnimatedSprite):
	sprite.play("Heal")
	yield(sprite, "animation_finished")
	sprite.play("Idle")
func hurt(sprite: AnimatedSprite):
	sprite.play("Hurt")
	yield(sprite, "animation_finished")
	sprite.play("Idle off")




