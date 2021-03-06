extends "res://Code/Enemies/Sprite.gd"

onready var enemy = get_parent()

func _ready():
	play("Walk")
	enemy.connect("died", self, "_on_enemy_died")
	
func _on_enemy_died():
	play("Die")
	yield(self, "animation_finished")
	play("Dead")
