extends YSort

func _ready():
	$Player.connect("shot", self, "on_player_shot")



func on_player_shot():
	print("SHOOT")
	$Camera2D.add_trauma(0.3)
	$Camera2D.add_zoom(0.98, 1)
