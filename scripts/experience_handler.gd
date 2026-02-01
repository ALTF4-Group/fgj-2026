extends Node2D

signal level_up(level: int)

@export var level = 0
@export var base_xp = 100
@export var growth = 1.2
@export var current_xp = 0
var to_next_level = 100

func _get_next_level_requirement() -> int:
	return floori(base_xp * growth ** level)

func _update_bar_on_level_up() -> void:
	$ProgressBar.value = current_xp
	$ProgressBar.max_value = to_next_level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_bar_on_level_up()
	GlobalEvents.enemy_died.connect(gain_xp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func gain_xp(amount: int) -> void:
	current_xp += amount
	if current_xp >= to_next_level:
		current_xp -= to_next_level
		level += 1
		level_up.emit(level)
		to_next_level = _get_next_level_requirement()
		_update_bar_on_level_up()
	else:
		$ProgressBar.value = current_xp
