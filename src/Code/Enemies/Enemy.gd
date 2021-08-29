extends KinematicBody2D

signal moved
signal died
signal hit

export var speed = 250
export var health: float = 1.0
export var damage: float = 1.0
export var knockbackSpeed = 300 
var move_dir = Vector2(1,0)
var hitstun = 0
var knockback = Vector2.ZERO
var dead = false


func _ready():
	$Healthbar.max_value = health
	$Healthbar.value = health
	$Healthbar.hide()
	
	$Node/locator.global_position = global_position
	var spawnsprite = $Node/locator/SpawnSprite
	spawnsprite.show()
	spawnsprite.play("Wind up")
	set_physics_process(false)
	hide()
	yield(spawnsprite, "animation_finished")
	spawnsprite.play("Fire")
	set_physics_process(true)
	show()
	


func _physics_process(delta):
	if not Globals.player:
		return
	enemy_process(delta)
	

func enemy_process(_delta):
	move_dir = get_dir_to_player()
	if hitstun == 0:
		var _vel = move_and_slide(move_dir * speed)
	else:
		var _vel = move_and_slide(knockback)
	if hitstun > 0:
		 hitstun -= 1
	emit_signal("moved")


func _knockback(dir, power):
	hitstun = 6
	knockback = (dir.normalized() * power) 

func damage(amt: float):
	health -= amt
	$Healthbar.value = health
	$Healthbar.show()
	if health <= 0:
		emit_signal("died")
		set_physics_process(false)
		disable_collisions()
		dead = true
		if is_in_group("spawned_enemies"):
			remove_from_group("spawned_enemies")
		$Healthbar.hide()
		
#		yield($Sprite, "animation_finished")
#		yield($Sprite, "animation_finished")
#		queue_free()
	else:
		emit_signal("hit")


### Helper functions ###
func disable_collisions():
	$Shape.set_deferred("disabled", true)


func get_dir_to_player() -> Vector2:
	return (Globals.player.global_position - global_position).normalized()


func move_to_ghost_layer(toggle: bool=true):
	call_deferred("set_collision_layer_bit", 3, toggle) 
	call_deferred("set_collision_layer_bit", 2, !toggle) 
	call_deferred("set_collision_mask_bit", 2, !toggle)

func get_distance_to_player() -> float:
	return Globals.player.global_position.distance_to(global_position)
