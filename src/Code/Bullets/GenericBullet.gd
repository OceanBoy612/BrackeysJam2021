extends KinematicBody2D


signal destroyed


export var speed = 300
export var damage = 1
export var rotate = true


onready var fragment_tscn = preload("res://Code/Fragmentation/Fragment.tscn")


var rotation_speed = 0


func _ready():
	if rotate:
		rotation_speed = rand_range(4, 12)


func _physics_process(delta):
	var _vel = move_and_slide(Vector2(1,0).rotated(rotation) * speed)
	$Sprite.rotation +=  rotation_speed * delta
	
	for i in get_slide_count():
		var col: KinematicCollision2D = get_slide_collision(i)
		if col.collider.has_method("damage"):
			col.collider.damage(damage)
			die()
			return
		elif col.collider is TileMap: # hit a wall
			die()
			return


func die():
	emit_signal("destroyed")
	set_physics_process(false)
	
	var fragment = fragment_tscn.instance()
	fragment.global_position = global_position
	fragment.text = $Sprite.texture
	get_parent().add_child(fragment)
	
	queue_free() 
