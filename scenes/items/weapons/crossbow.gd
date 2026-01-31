extends Node2D

var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")
@export var damage := 1
@export var projectile_speed := 100
@export var pierce := 0


func _ready() -> void:
	pass


func shoot():
	var pos_marker = $Marker2D
	var bullet = bullet_scene.instantiate()
	var trajectory = Vector2(pos_marker.position.x, pos_marker.position.y)
	bullet.rotation = $".".rotation
	bullet.create(trajectory, trajectory.normalized(), projectile_speed, damage)
	
	$".".add_child(bullet)
	pass
