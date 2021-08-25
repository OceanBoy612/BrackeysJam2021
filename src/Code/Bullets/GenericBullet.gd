extends KinematicBody2D


signal destroyed


export var speed: float = 300
export var damage = 1
#export(int, 25, 1000, 25) var distance = 200 # distance in pixels the bullet will travel
export var time_alive: float = 1.0
export var shot_cone = 0.0 # 0 means perfectly accurate, 30 means bullets can go anywhere in a 30 degree cone
export var rotate = true
export var break_sound: AudioStream
export var scene_to_spawn: PackedScene


onready var fragment_tscn = preload("res://Code/Fragmentation/Fragment.tscn")


var rotation_speed = 0
var distance_traveled = 0
var decay_rate: float
var max_speed: float


func _ready():
	if rotate:
		rotation_speed = rand_range(4, 12)
	rotation_degrees += rand_range(-shot_cone/2, shot_cone/2)
	
	$Tween.interpolate_property(self, "speed", speed, 0, time_alive, Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()
	


func _physics_process(delta):
#	distance_traveled += speed * delta
#	print(speed, "   ", distance_traveled)
	
	var _vel = move_and_slide(Vector2(1,0).rotated(rotation) * speed)
	$Sprite.rotation +=  rotation_speed * delta
	
	if speed == 0:
		die()
		return
	
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
#	fragment.text = $Sprite.texture
	fragment.init($Sprite.texture, break_sound)
	get_parent().add_child(fragment)
	
	if scene_to_spawn:
		var s = scene_to_spawn.instance()
		s.global_position = global_position
		if s.has_method("init"):
			s.init(self)
		get_parent().add_child(s)
	
	queue_free() 

