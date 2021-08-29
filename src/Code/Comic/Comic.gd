extends Control


signal finished


export var fade_dur = 1.0


var max_frames = 14
onready var i_frame = max_frames


func _input(event):
	if event.is_action("shoot") and event.is_pressed():
		next_frame()


func next_frame():
	$Timer.start(0)
	
	for i in get_child_count():
		var frame = get_child(i)
		if not frame is TextureRect:
			continue
		if i > i_frame:
			frame.hide()
		elif i == i_frame:
			disapear(frame)
		else:
			frame.show()
			frame.modulate = Color(1,1,1,1)
	i_frame -= 1
	
	if i_frame <= 0:
		emit_signal("finished")
		reset_comic()
	

func reset_comic():
	i_frame = max_frames
	next_frame()


func disapear(control: Control):
	var tween: Tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(control, "modulate", modulate, Color(1,1,1,0), fade_dur)
	tween.start()
	tween.connect("tween_all_completed", self, "kill_tween", [tween])


func kill_tween(tween: Tween):
#	print("tween dead")
	tween.queue_free()


func _on_Timer_timeout():
	next_frame()
	pass # Replace with function body.
