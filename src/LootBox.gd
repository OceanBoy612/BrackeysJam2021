extends Node2D

var looted = false

export(PackedScene) var item1
export(PackedScene) var item2
export(PackedScene) var item3
export(PackedScene) var item4
export(PackedScene) var item5
export(PackedScene) var item6
export(PackedScene) var item7
export(PackedScene) var item8
export(PackedScene) var item9


func _get_loot():
	if looted:
		return
	else:
		var lootnum = int(rand_range(1, 11))
		var entity_tscn = item1
		match lootnum:
			2:
				entity_tscn = item2
			3:
				entity_tscn = item3
			4:
				entity_tscn = item4
			5:
				entity_tscn = item5
			6:
				entity_tscn = item6
			7:
				entity_tscn = item7
			8:
				entity_tscn = item8
			9:
				entity_tscn = item9
		var entity = entity_tscn.instance()
		entity.global_position = global_position
		$SpawnedEntities.add_child(entity)
		
		emit_signal("spawned_loot")
