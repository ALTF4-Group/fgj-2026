extends Area2D
class_name TestItem

@export var health_increase := 1

func _ready() -> void:
	pass
	
	
func apply(target: Node2D) -> void:
	if target.name == "Player":
		target.health += 1

func get_item_name() -> String:
	return "HEALTH POTION"
