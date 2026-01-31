extends CharacterBody2D
# @export var name = Player
@export var speed = 6000
@export var speed_mult = 1
@export var health = 10
@export var xp = 0
@export var attack_speed = 1
@export var attack_damage = 1
@export var attack_range = 1
@export var mob_scene: PackedScene
@export var weapons = { 
	"cleave" : preload("res://scenes/items/weapons/Cleave.tscn")
	}
var starting_weapon = weapons["cleave"].instantiate()
var weapon_enabled = true

func _ready() -> void:
	Global.player = self
	add_child(starting_weapon)
	$MobTimer.start()

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed * delta
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_select"):
		remove_child(starting_weapon) if weapon_enabled == true else add_child(starting_weapon)
		weapon_enabled = !weapon_enabled

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobSpawner/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position + position

	# Spawn the mob by adding it to the Main scene.
	add_sibling(mob)

func look():
	look_at(get_global_mouse_position())
