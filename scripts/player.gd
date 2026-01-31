extends CharacterBody2D
# @export var name = Player
@export var speed = 100
@export var speed_mult = 1
@export var health = 10
@export var xp = 0
@export var attack_speed = 1
@export var attack_damage = 1
@export var attack_range = 1
@export var weapons = []

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
	
	move_and_slide()
	
func look():
	look_at(get_global_mouse_position())
