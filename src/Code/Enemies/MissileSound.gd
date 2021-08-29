extends AudioStreamPlayer2D


onready var enemy = get_parent()


func _ready():
	enemy.connect("moved", self, "_on_Enemy_moved")
	enemy.connect("state_changed", self, "_on_Enemy_landed")
	enemy.connect("died", self, "_on_Enemy_died")


func _on_Enemy_moved():
	if enemy.state == enemy.CHARGING and not is_playing():
		play()

func _on_Enemy_landed():
	if enemy.state == enemy.LANDING  && is_playing():
		stop()
		
		
func _on_Enemy_died():
	stop()
