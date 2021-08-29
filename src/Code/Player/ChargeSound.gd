extends AudioStreamPlayer2D


onready var player: Player = get_parent() as Player


func _ready():
#	player.connect("charged", self, "_on_Player_charged")
	player.connect("shot", self, "_on_Player_shot")


var charging = false

func _process(delta):
	if charging and not is_playing():
		play()


func _on_Player_charged():
	if not is_playing():
		play()

func _on_Player_shot():
	charging = false
	if is_playing():
		stop()


func _on_Blunderbuss_super_charged():
	charging = true
#	if not is_playing():
#		play()
	pass # Replace with function body.
	
