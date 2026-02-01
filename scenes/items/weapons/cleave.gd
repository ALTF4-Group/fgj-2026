extends Area2D

@export var damage := 1
@export var rotation_speed := 3.0
@export var knockback := 1.0
@export var level := 1

const levels = [
	{
		"damage": 1,
		"rotation_speed": 3.0,
		"knockback": 1
	},
	{
		"damage": 2,
		"rotation_speed": 3.0,
		"knockback": 1
	},
	{
		"damage": 2,
		"rotation_speed": 4.0,
		"knockback": 2
	},
	{
		"damage": 3,
		"rotation_speed": 5.0,
		"knockback": 2
	},
	{
		"damage": 5,
		"rotation_speed": 6.0,
		"knockback": 3
	}
]

func _set_stats_from_level() -> void:
	print("stats set")
	damage = levels[level]["damage"]
	rotation_speed = levels[level]["rotation_speed"]
	knockback = levels[level]["knockback"]

func _ready() -> void:
	_set_stats_from_level()

func _physics_process(delta: float) -> void:
	$".".rotate(rotation_speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(damage)

func level_up() -> void:
	print("level up")
	if level + 1 >= len(levels):
		return
	level += 1
	_set_stats_from_level()
