extends AudioStreamPlayer2D


onready var player: Player = get_parent() as Player


func _ready():
	player.connect("moved", self, "_on_Player_moved")
	player.connect("stopped", self, "_on_Player_stopped")


func _on_Player_moved():
	if not is_playing():
		play()

func _on_Player_stopped():
	if is_playing():
		stop()
