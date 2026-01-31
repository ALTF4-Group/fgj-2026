extends Node2D

var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")
@export var damage := 1
@export var projectile_speed := 10000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func shoot():
	var pos = Global.player.global_position
	var pos_marker = $Marker2D
	
	
	pass
