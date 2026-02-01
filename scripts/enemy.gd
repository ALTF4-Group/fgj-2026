extends CharacterBody2D

@export var player = Node2D
@export var health = 1
@export var damage = 1
@export var experience = 5
var speed = 500

func _ready() -> void:
	GlobalEvents.enemy_spawned.emit()
	pass

func _physics_process(delta) -> void:
	var direction = (Global.player.position - position).normalized()
	velocity = direction * speed * delta
	move_and_slide()

func take_damage(damage: int):
	health -= damage
	if health <= 0:
		GlobalEvents.enemy_died.emit(experience)
		queue_free()
