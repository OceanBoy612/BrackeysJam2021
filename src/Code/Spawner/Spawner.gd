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
#	if amount>0:
	$Timer.start()
	emit_signal("created")


func _on_Timer_timeout():
	spawn_entity()
	

func spawn_entity():
	$Sprite.show()
	$Sprite.play("Wind up")
	yield($Sprite, "animation_finished")
	$Sprite.play("Fire")
	
	if amount == 0:
		emit_signal("destroyed")
#		queue_free()
		$Timer.stop()
		return 
	
	var entity = entity_tscn.instance()
	entity.global_position = global_position
	$SpawnedEntities.add_child(entity)
	
	emit_signal("spawned_entity")
	
	amount -= 1
	
	yield($Sprite, "animation_finished")
	$Sprite.hide()

















