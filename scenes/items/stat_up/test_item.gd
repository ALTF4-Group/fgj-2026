extends Area2D
@export var health_increase := 1

func _ready() -> void:
	pass
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.health += 1
		print(body.health)
