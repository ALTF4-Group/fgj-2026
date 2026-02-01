extends Area2D

var source: Object
var direction: Vector2
var projectile_speed: int
var bullet_damage: int
var pierce: int
var knockback: int


func create(pos:Vector2, dir: Vector2, speed: int, damage: int, initial_pierce: int = 1, initial_knockback: int = 1):
	direction = dir
	position = pos
	projectile_speed = speed
	bullet_damage = damage
	pierce = initial_pierce
	knockback = initial_knockback


func _physics_process(delta: float) -> void:
	position += direction * projectile_speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if pierce <= 0:
		return
	if body.is_in_group("enemies"):
		pierce -= 1
		body.take_damage(bullet_damage)
		if pierce <= 0:
			queue_free()
