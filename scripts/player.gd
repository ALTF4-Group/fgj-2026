extends CharacterBody2D
# @export var name = Player
@export var speed = 6000
@export var speed_mult = 1
@export var health = 10
@export var xp = 0
@export var attack_speed = 1
@export var attack_damage = 1
@export var attack_range = 1
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
@export var weapons = { 
	"cleave" : preload("res://scenes/items/weapons/cleave.tscn"),
	"boomerang" : preload("res://scenes/items/weapons/boomerang.tscn"),
	"crossbow" : preload("res://scenes/items/weapons/Cross_cross_bow.tscn"),
	"hammer" : preload("res://scenes/items/weapons/hamme_of_justice.tscn")
	}

func _ready() -> void:
	Global.player = self
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 3.0
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	

func _physics_process(delta: float) -> void:
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed * delta
	
	move_and_slide()
	
func _on_timer_timeout() -> void:
	var hammer = weapons["hammer"].instantiate()
	add_child(hammer)

func look():
	look_at(get_global_mouse_position())
