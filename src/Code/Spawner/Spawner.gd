extends Position2D


signal spawned_entity
signal created
signal destroyed


export(PackedScene) var entity_tscn
export var amount: int = 3
export var delay: float = 1


func _ready():
	add_to_group("spawners")
	$Timer.wait_time = delay
	$Timer.start()
	emit_signal("created")


func _on_Timer_timeout():
	var entity = entity_tscn.instance()
#	entity.global_position = global_position - position
	add_child(entity)
	
	emit_signal("spawned_entity")
	
	amount -= 1
	if amount <= 0:
		emit_signal("destroyed")
#		queue_free()
		$Timer.stop()
	
