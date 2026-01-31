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
  "crossbow" : preload("res://scenes/items/weapons/Cross_cross_bow.tscn")
	}
var starting_weapon = weapons["cleave"].instantiate()
var weapon_enabled = true

func _ready() -> void:
	Global.player = self
	add_child(starting_weapon)
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	
func update_animation():
	#Flip the sprite when changing direction
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	#Play "move" animation when moving
	if velocity.length() > 0:
		$AnimatedSprite2D.play("move")
	#Play idle animation when standing still
	else:
		$AnimatedSprite2D.play("Mask")


func _physics_process(delta: float) -> void:
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed * delta
	
	move_and_slide()
	
	update_animation()
	
	if Input.is_action_just_pressed("ui_select"):
		remove_child(starting_weapon) if weapon_enabled == true else add_child(starting_weapon)
		weapon_enabled = !weapon_enabled

func _on_timer_timeout() -> void:
	var second_weapon = weapons["boomerang"].instantiate()
	add_sibling(second_weapon)

func look():
	look_at(get_global_mouse_position())

func die():
	var timer = Timer.new()

	#Stop movement, remove weapons, play death animation and then fade to black DUNDUNDUUUUN
	if health <= 0:
		add_child(timer)
		timer.wait_time = 10.0
		timer.start()
		timer.timeout.connect(on_timer_death_time_out())
		speed_mult=0
		$AnimatedSprite2D.play("death")
		weapon_enabled=false
		get_node("/Player/CanvasLayer/FadeRect").fade_to_black(1.5)
		set_physics_process(false)
		

func on_timer_death_time_out():
	print("You died!")
	get_tree().quit()
