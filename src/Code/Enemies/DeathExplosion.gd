extends AnimatedSprite


onready var enemy = get_parent()


func _ready():
	enemy.connect("died", self, "_on_enemy_died")


func _on_enemy_died():
	frame = 0
	play()

