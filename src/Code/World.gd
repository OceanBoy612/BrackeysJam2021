extends YSort

func _ready():
	$Player.connect("shot", self, "on_player_shot")
	$Player.connect("charged", self, "on_player_charged")
	$Player.connect("moved", self, "on_player_moved")


func on_player_charged():
	$Camera2D.add_zoom(0.105)
	$Camera2D.add_trauma(0.016, 0.15)

func on_player_shot():
	$Camera2D.add_trauma(0.3)
#	$Camera2D.add_zoom(0.2)

func on_player_moved():
#	$Camera2D.add_zoom(0.10)
	$Camera2D.add_trauma(0.016, 0.1)
