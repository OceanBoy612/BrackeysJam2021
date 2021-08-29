extends Control


signal finished


export var fade_dur = 1.0


var max_frames = 15
var last_frame = 1
onready var i_frame = max_frames


func _ready():
	next_frame()


func _input(event):
	if event.is_action("shoot") and event.is_pressed():
		print(i_frame)
		if i_frame > 1:
			next_frame()


func next_frame():
	$Timer.start(0)
	
	for i in get_child_count():
		var frame = get_child(i)
		if not frame is TextureRect:
			continue
		if i > i_frame:
#			frame.hide()
			pass
		elif i == i_frame:
			disapear(frame)
		else:
			frame.show()
			frame.modulate = Color(1,1,1,1)
	i_frame -= 1
	
	

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
	if i_frame == last_frame:
		emit_signal("finished")
		print("!!!")
		$Timer.stop()
		


func _on_Timer_timeout():
	if i_frame > last_frame:
		next_frame()
	pass # Replace with function body.
