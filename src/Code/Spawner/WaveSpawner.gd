tool
extends Node2D


signal all_enemies_killed


export(Array, PackedScene) var enemy_tscns
export var min_enemies = 3
export var max_enemies = 4
export var waves = 3
export var delay_between_waves = 0.7

var enemies_spawned = 0


func _ready():
	if Engine.is_editor_hint():
		return
	
	add_to_group("wave_spawners")


func spawn_wave():
	if not is_processing():
		return
	if waves <= 0:
		return
	
	var enemies_to_spawn:int = rand_range(min_enemies, max_enemies) as int
	var spawn_positions = get_spawn_positions()
	for i in enemies_to_spawn:
		var enemy = enemy_tscns[randi() % enemy_tscns.size()].instance()
		var pos: Vector2 = global_position
		if spawn_positions.size() > 0:
			spawn_positions.shuffle()
			pos = spawn_positions.pop_back()
	#		pos = spawn_positions[randi() % spawn_positions.size()]
		enemy.global_position = pos
		enemy.set_as_toplevel(true)
		add_child(enemy)
		enemy.add_to_group("spawned_enemies")
		enemy.connect("died", self, "on_spawned_enemy_died")
		enemies_spawned += 1
	waves -= 1


func on_spawned_enemy_died():
	enemies_spawned -= 1
	if enemies_spawned <= 0:
		if waves <= 0:
			emit_signal("all_enemies_killed")
		else:
			yield(get_tree().create_timer(delay_between_waves), "timeout")
			spawn_wave()


func get_spawn_positions() -> Array:
	if get_children().size() > 2:
		var positions = []
		for child in get_children():
			positions.append(child.global_position)
		return positions
	else:
		return [global_position]


func _get_configuration_warning():
	if get_child_count() <= 1:
		return "WaveSpawner requires Position2D children in order to know where to spawn enemies"
	return ""

