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
	"boomerang" : preload("res://scenes/items/weapons/boomerang.tscn")
	}

var current_weapon = weapons["cleave"].instantiate()

var weapon_select = 0

func _ready() -> void:
	Global.player = self
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	

func _physics_process(delta: float) -> void:
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed * delta
	
	move_and_slide()
	
func _on_timer_timeout() -> void:
	var second_weapon = weapons["boomerang"].instantiate()
	add_sibling(second_weapon)

func look():
	look_at(get_global_mouse_position())
