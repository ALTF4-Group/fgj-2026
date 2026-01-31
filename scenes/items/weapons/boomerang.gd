extends Area2D

enum State { INACTIVE, THROW, RETURN }

@export var damage := 1
@export var rotation_speed := 6.0
@export var speed : float = 0
var direction : Vector2
@export var acceleration : float = 250.0
@export var max_speed : float = 200.0
var state

func _physics_process( delta: float ) -> void:
	$".".rotate(-rotation_speed * delta)
	if state == State.THROW:
		speed -= acceleration * delta
		position += direction * speed * delta
		if speed <= 0:
			state = State.RETURN
		pass
	elif state == State.RETURN:
		direction = global_position.direction_to( Global.player.global_position )
		speed += acceleration * delta
		position += direction * speed * delta
		if global_position.distance_to( Global.player.global_position ) <= 10:
			queue_free()
		pass
	var speed_ratio = speed / max_speed
	pass

func throw( throw_direction : Vector2 ) -> void:
	direction = throw_direction
	speed = max_speed
	state = State.THROW
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print("Hit!")
		#body.health -= damage
		#print(body.health)

func _on_tree_entered() -> void:
	position = Global.player.global_position
	state = State.THROW
	var throw_direction = Global.player.direction
	if throw_direction == Vector2.ZERO:
		throw_direction = Global.player.cardinal_direction
	throw(throw_direction)
