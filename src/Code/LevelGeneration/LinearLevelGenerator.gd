extends Node2D


onready var Back : TileMap = $Back
onready var Mid : TileMap = $Mid
onready var Front : TileMap = $Front


onready var rooms_tscn = preload("res://Code/LevelGeneration/Rooms.tscn")


func spawn_level():
	pass

