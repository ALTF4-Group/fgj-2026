extends Area2D

@export var damage := 1
@export var rotation_speed := 3.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var player_pos = Global.player.global_position
	$".".rotate(rotation_speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print("hit")
		body.take_damage(damage)
