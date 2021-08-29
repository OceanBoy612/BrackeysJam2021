extends YSort


onready var player: Player = $Player
onready var cam: Camera2D = $Camera2D


func _ready():
	player.connect("shot", self, "on_player_shot")
	player.connect("charged", self, "on_player_charged")
#	player.connect("moved", self, "on_player_moved")
	player.connect("died", self, "on_player_died")
	player.connect("hit", self, "on_player_hit")


func on_player_charged():
	cam.add_zoom(0.105)
	cam.add_trauma(0.016, 0.15)

func on_player_shot():
	cam.add_trauma(0.3, 0.55)
#	cam.add_zoom(0.2)

func on_player_hit():
	cam.add_trauma(0.5, 0.5)


func on_player_died():
	get_tree().reload_current_scene()
