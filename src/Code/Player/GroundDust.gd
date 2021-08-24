extends AnimatedSprite


onready var player: Player = get_parent()


var old_move_dir: Vector2 = Vector2()


func _ready():
	player.connect("moved", self, "on_player_moved")


func on_player_moved():
	check_flip()
	
	var dot_product = player.move_dir.dot(old_move_dir)
	if dot_product < 0.9 and frame == 5:
		frame = 0
		play("Idle")
	
	old_move_dir = player.move_dir


func check_flip():
	if player.aiming_dir.x > 0:
		flip_h = false
		position.x = -abs(position.x)
	else:
		flip_h = true
		position.x = abs(position.x)
