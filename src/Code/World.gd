extends YSort

func _ready():
	$Player.connect("shot", self, "on_player_shot")
	$Player.connect("charged", self, "on_player_charged")


func on_player_charged():
	$Camera2D.add_zoom(0.1)
	$Camera2D.add_trauma(0.016)

func on_player_shot():
	$Camera2D.add_trauma(0.2)
#	$Camera2D.add_zoom(0.2)
