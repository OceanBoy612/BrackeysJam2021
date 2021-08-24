extends AnimatedSprite


onready var enemy = get_parent()
const LAST_HIT_FRAME = 4


func _ready():
	enemy.connect("hit", self, "_on_enemy_hit")


func _on_enemy_hit():
	if frame == LAST_HIT_FRAME:
		frame = 0
		play()

