extends AudioStreamPlayer2D


onready var player: Player = get_parent() as Player


func _ready():
	player.connect("charged", self, "_on_Player_charged")
	player.connect("shot", self, "_on_Player_shot")


func _on_Player_charged():
	if not is_playing():
		play()

func _on_Player_shot():
	if is_playing():
		stop()
