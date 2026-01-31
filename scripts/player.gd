extends CharacterBody2D
# @export var name = Player
@export var speed = 100
@export var speed_mult = 1
@export var health = 10
@export var xp = 0
@export var attack_speed = 1
@export var attack_damage = 1
@export var attack_range = 1
@export var weapons = { 
	"cleave" : preload("res://scenes/items/weapons/Cleave.tscn")
	}	
var starting_weapon = weapons["cleave"].instantiate()
var weapon_enabled = true

func _ready() -> void:
	Global.player = self
	add_child(starting_weapon)
	
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var left_rigth := Input.get_axis("left", "right")
	if left_rigth:
		velocity.x = left_rigth * speed * speed_mult
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	var up_down := Input.get_axis("up", "down")
	if up_down:
		velocity.y = up_down * speed * speed_mult
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
		
	if Input.is_action_just_pressed("ui_select"):
		if weapon_enabled == true:
			weapon_enabled = false
			remove_child(starting_weapon)
		elif  weapon_enabled == false:
			weapon_enabled = true
			add_child(starting_weapon)
	
	move_and_slide()
	
func look():
	look_at(get_global_mouse_position())
