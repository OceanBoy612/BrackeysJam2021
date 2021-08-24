extends Node


var player: Player

onready var items = {
	"knife": preload("res://Code/Bullets/KnifeBullet.tscn"),
	"broom": preload("res://Code/Bullets/BroomBullet.tscn"),
	"lamp": preload("res://Code/Bullets/LampBullet.tscn"),
	"chair": preload("res://Code/Bullets/ChairBullet.tscn"),
}

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

