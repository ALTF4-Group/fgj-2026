extends Node2D

var crossbow_scene: PackedScene = preload("res://scenes/items/weapons/crossbow.tscn")
@export var shoot_interval := 1
@export var rotation_speed := 0
@export var number_of_bows = 4
@export var level := 0
var list_of_bows = []

const levels = [
	{
		"shoot_interval": 1,
		"rotation_speed": 0,
		"number_of_bows": 4,
		"damage": 1,
		"pierce": 1,
		"knockback": 1,
		"projectile_speed": 200
	},
	{
		"shoot_interval": 0.9,
		"rotation_speed": 0,
		"number_of_bows": 4,
		"damage": 1,
		"pierce": 2,
		"knockback": 1,
		"projectile_speed": 250
	},
	{
		"shoot_interval": 0.8,
		"rotation_speed": 0,
		"number_of_bows": 4,
		"damage": 2,
		"pierce": 2,
		"knockback": 2,
		"projectile_speed": 300
	},
	{
		"shoot_interval": 0.7,
		"rotation_speed": 0,
		"number_of_bows": 4,
		"damage": 3,
		"pierce": 3,
		"knockback": 3,
		"projectile_speed": 350
	},
	{
		"shoot_interval": 0.7,
		"rotation_speed": 1,
		"number_of_bows": 8,
		"damage": 3,
		"pierce": 3,
		"knockback": 3,
		"projectile_speed": 400
	}
]

func _set_attributes_from_level() -> void:
	var current_degree = 0
	shoot_interval = levels[level]["shoot_interval"]
	rotation_speed = levels[level]["rotation_speed"]
	number_of_bows = levels[level]["number_of_bows"]
	for i in range(number_of_bows):
		var crossbow = crossbow_scene.instantiate()
		crossbow.rotation = current_degree
		crossbow.damage = levels[level]["damage"]
		crossbow.pierce = levels[level]["pierce"]
		crossbow.knockback = levels[level]["knockback"]
		crossbow.projectile_speed = levels[level]["projectile_speed"]
		current_degree += PI/number_of_bows*2
		list_of_bows.append(crossbow)
		$".".add_child(crossbow)

func _ready() -> void:
	_set_attributes_from_level()


func _process(delta: float) -> void:
	$".".rotate(rotation_speed * delta)


func _on_timer_timeout() -> void:
	for bow in list_of_bows:
		bow.shoot()
	$Timer.wait_time = shoot_interval

func level_up() -> void:
	if level + 1 >= len(levels):
		return
	for bow in list_of_bows:
		bow.queue_free()
	list_of_bows = []
	level += 1
	_set_attributes_from_level()
	
