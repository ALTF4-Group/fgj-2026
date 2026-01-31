extends CharacterBody2D

@export var player = Node2D
@export var hp = 1
@export var damage = 1
var speed = 100

func _ready() -> void:
	pass

func _physics_process(delta) -> void:
	var direction = (player.position - position).normalized()
	velocity = direction * speed
	move_and_slide()
