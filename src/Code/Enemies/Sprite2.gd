extends Sprite

func _process(_delta):	
	if get_parent().move_dir.x < 0:
		flip_h = true
	else:
		flip_h = false

