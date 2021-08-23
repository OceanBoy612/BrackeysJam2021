extends Area2D

signal picked_up

export var item_name = "Null"


func _on_GenericItem_body_entered(body):
	# item was picked up
	if body.has_method("pickup_item"):
		print(item_name)
		body.pickup_item(item_name)
		emit_signal("picked_up")
		queue_free()
