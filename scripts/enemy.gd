extends CharacterBody2D

@export var player = Node2D
@export var health = 1
@export var damage = 1
@export var experience = 5
var speed = 500

func _ready() -> void:
	Global.enemy_counter += 1
	pass

func _physics_process(delta) -> void:
	var direction = (Global.player.position - position).normalized()
	velocity = direction * speed * delta
	move_and_slide()

func take_damage(damage: int):
	health -= damage
	if health <= 0:
		Global.player.on_kill(experience)
		Global.enemy_counter -= 1
		queue_free()
