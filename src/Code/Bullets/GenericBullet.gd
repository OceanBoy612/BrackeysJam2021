extends KinematicBody2D


export var speed = 300
export var damage = 1
var rotation_speed = 0
export var rotate = true

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
			queue_free()
		if col.collider is TileMap:
			queue_free() # hit a wall
		
