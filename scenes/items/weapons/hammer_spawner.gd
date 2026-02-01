extends Node

@export var attack_interval: float = 5.0
@export var damage: int = 3
@export var knockback: float = 2
@export var level: int = 0

var hammer_scene = preload("res://scenes/items/weapons/hamme_of_justice.tscn")
var timer = null

const levels = [
	{
		"damage": 3,
		"knockback": 2,
		"attack_interval": 5.0
	},
	{
		"damage": 4,
		"knockback": 2,
		"attack_interval": 5.0
	},
	{
		"damage": 5,
		"knockback": 3,
		"attack_interval": 4.0
	},
	{
		"damage": 6,
		"knockback": 3,
		"attack_interval": 4.0
	},
	{
		"damage": 8,
		"knockback": 4,
		"attack_interval": 3.0
	}
]

func _set_stats_from_level() -> void:
	damage = levels[level]["damage"]
	knockback = levels[level]["knockback"]
	attack_interval = levels[level]["attack_interval"]
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = attack_interval
	timer.start()
	timer.timeout.connect(_spawn_hammer)
	_spawn_hammer()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_stats_from_level()

func _spawn_hammer() -> void:
	var hammer = hammer_scene.instantiate()
	add_child(hammer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func level_up() -> void:
	if level + 1 >= len(levels):
		return
	level += 1
	_set_stats_from_level()
