extends Node


var player: Player

onready var items = {
	"knife": preload("res://Code/Bullets/KnifeBullet.tscn"),
	"broom": preload("res://Code/Bullets/BroomBullet.tscn"),
	"lamp": preload("res://Code/Bullets/LampBullet.tscn"),
	"chair": preload("res://Code/Bullets/ChairBullet.tscn"),
	"bomb": preload("res://Code/Bullets/BombBullet.tscn"),
	"hedgehog": preload("res://Code/Bullets/HedgeHogBullet.tscn"),
	"teddy": preload("res://Code/Bullets/TeddyBullet.tscn"),
	"teapot": preload("res://Code/Bullets/TeapotBullet.tscn"),
	"quill": preload("res://Code/Bullets/QuillBullet.tscn"),
	"pumpkin": preload("res://Code/Bullets/PumpkinBullet.tscn"),
	"flower": preload("res://Code/Bullets/FlowerBullet.tscn"),
}

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

