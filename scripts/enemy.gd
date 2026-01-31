extends CharacterBody2D

@export var player = Node2D
@export var health = 1
@export var damage = 1
var speed = 500

func _ready() -> void:
	add_to_group("enemies")
	Global.enemy_counter += 1
	pass

func _physics_process(delta) -> void:
	var direction = (Global.player.position - position).normalized()
	velocity = direction * speed * delta
	move_and_slide()

func take_damage(damage: int):
	health -= damage
	if health <= 0:
		Global.enemy_counter -= 1
		queue_free()
