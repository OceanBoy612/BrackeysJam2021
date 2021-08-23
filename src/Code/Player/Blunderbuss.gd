extends AnimatedSprite


signal shot


var charging = false
var firing = false
var charged = false
var got_shoot_signal = false


func windup():
	if charging or charged:
		return
	
	got_shoot_signal = false
	charging = true
	play("Wind up")
	yield(self, "animation_finished")
	play("Charging")
	yield(self, "animation_finished")
	charging = false
	
	charged = true
	
	if got_shoot_signal:
		release()


func shoot():
	got_shoot_signal = true
	if not charging and charged:
		release()
	else:
		push_error("WHAT?")


func release():
	if firing:
		return
	if not charged or charging:
		push_error("Tried to release gun when it wasn't charged or it was charging %s %s" % [not charged, charging])
		return 
	
	firing = true
	play("Fire")
	emit_signal("shot")
	yield(self, "animation_finished")
	play("Idle")
	charged = false
	firing = false
	
	got_shoot_signal = false
