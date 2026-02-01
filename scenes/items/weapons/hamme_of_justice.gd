extends Area2D

@export var damage := 1
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(damage)

func _on_tree_entered() -> void:
	$AnimationPlayer.play("strike")
	$CollisionShape2D.set_deferred("disabled", true)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "strike":
		queue_free()
