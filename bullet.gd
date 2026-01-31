extends Area2D

var source: Object
var direction: Vector2
var speed: float

func shoot(pos:Vector2, dir: Vector2, origin: Object):
	direction = dir
	position = pos
	source = origin
	speed = source.speed

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
