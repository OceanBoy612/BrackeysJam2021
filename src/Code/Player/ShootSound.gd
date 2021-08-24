extends AudioStreamPlayer2D


onready var player: Player = get_parent() as Player


func _ready():
	player.connect("shot", self, "_on_Player_shot")


func _on_Player_shot():
	play()
