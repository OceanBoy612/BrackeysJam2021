extends KinematicBody2D


export var speed = 300
export var damage = 1

func _physics_process(_delta):
	var _vel = move_and_slide(Vector2(1,0).rotated(rotation) * speed)
	
	for i in get_slide_count():
		var col: KinematicCollision2D = get_slide_collision(i)
		if col.collider.has_method("damage"):
			col.collider.damage(damage)
			queue_free()
		
