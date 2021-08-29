extends Control


onready var player: Player = get_parent().get_parent() as Player



func _ready():
	player.connect("hit", self, "on_player_hit")
	player.connect("shot", self, "_on_player_shot")
	player.connect("picked_up_item", self, "_on_player_shot")
	player.connect("shuffled_deck", self, "_on_player_shot")
	yield(player, "ready")
	_on_player_shot()


func _on_player_shot():
	print(player.draw_pile)
	if player.draw_pile.size() > 0:
		var bullet = Globals.items[player.draw_pile[0]].instance()
		$NextBullet/Sprite.texture = bullet.get_node("Sprite").texture


func on_player_hit():
#	for lifeicon in $HBoxContainer.get_children():
	for i in range($HBoxContainer.get_child_count()):
		var lifeicon = $HBoxContainer.get_child(i)
		var sprite = lifeicon.get_child(0) as AnimatedSprite
		if i < player.health:
			match sprite.animation:
				"Idle":
					pass # do nothing
				"Idle off":
					heal(sprite)
		elif i >= player.health:
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




