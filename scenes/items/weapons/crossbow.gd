extends Node2D

var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")
@export var damage := 1
@export var projectile_speed := 200
@export var pierce := 1
@export var knockback := 1


func _ready() -> void:
	pass


func shoot():
	var pos_marker = $Marker2D
	var bullet = bullet_scene.instantiate()
	var trajectory = Vector2(pos_marker.position.x, pos_marker.position.y)
	bullet.create(trajectory, trajectory.normalized().rotated(rotation), projectile_speed, damage, pierce, knockback)
	bullet.position = position + Global.player.position
	
	get_tree().current_scene.add_child(bullet)
