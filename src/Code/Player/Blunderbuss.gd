extends AnimatedSprite


signal shot

signal wound_up
signal charged
signal fired
signal idled
signal reloaded

signal super_charged


var charging = false
var firing = false
var charged = false
var got_shoot_signal = false
var reloading = false


func windup():
	if reloading:
		return
	if charging or charged:
		return
	
	got_shoot_signal = false
	charging = true
	play("Wind up")
	emit_signal("wound_up")
	yield(self, "animation_finished")
	play("Charging")
	emit_signal("charged")
	yield(self, "animation_finished")
	charging = false
	
	charged = true
	
	if got_shoot_signal:
		release()
	else:
		print("HAHA")
		emit_signal("super_charged")


func shoot():
	got_shoot_signal = true
	if not charging and charged:
		release()
#	else:
#		push_error("WHAT?")


func release():
	if firing:
		return
	if not charged or charging:
		push_error("Tried to release gun when it wasn't charged or it was charging %s %s" % [not charged, charging])
		return 
	
	firing = true
	play("Fire")
	emit_signal("fired")
	emit_signal("shot")
	yield(self, "animation_finished")
	play("Idle")
	emit_signal("idled")
	charged = false
	firing = false
	
	got_shoot_signal = false


func reload():
	reloading = true
	play("Reload")
	yield(self, "animation_finished")
	emit_signal("reloaded")
	play("Idle")
	reloading = false
