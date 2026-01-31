extends Area2D

var source: Object
var direction: Vector2
var projectile_speed: int
var bullet_damage: int

func create(pos:Vector2, dir: Vector2, speed: int, damage: int):
	direction = dir
	position = pos
	projectile_speed = speed
	bullet_damage = damage

func _physics_process(delta: float) -> void:
	position += direction * projectile_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
