extends Node2D

var crossbow_scene: PackedScene = preload("res://scenes/items/weapons/crossbow.tscn")
@export var shoot_interval := 1
@export var rotation_speed := 1.0
@export var number_of_bows = 4
var list_of_bows = []

func _ready() -> void:
	var current_degree = 0
	for i in range(number_of_bows):
		var crossbow = crossbow_scene.instantiate()
		crossbow.rotation = current_degree
		current_degree += PI/number_of_bows*2
		list_of_bows.append(crossbow)
		$".".add_child(crossbow)
	pass 



func _process(delta: float) -> void:
	#var player_pos = Global.player.global_position
	$".".rotate(rotation_speed * delta)
	pass


func _on_timer_timeout() -> void:
	for bow in list_of_bows:
		bow.shoot()
	$Timer.wait_time = shoot_interval
	pass # Replace with function body.
