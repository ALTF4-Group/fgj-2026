# speechbox.gd
extends Control

class_name SpeechBox

# Signals
signal popup_opened()
signal popup_closed()

# Variables
var text: String 
var duration: float = 3.0  # Time in seconds before the popup disappears
var is_visible: bool = false
var offset: Vector2 = Vector2(0, 0)  # Offset above the enemy position

# Nodes
@onready var label: Label = $PanelContainer/Label

func _ready():
	# Hide popup initially
	visible = false

# Public Methods
func show_popup(new_text: String = "", custom_duration: float = 0.0):
	if custom_duration <= 0.0:
		return
		
	duration = custom_duration
	text = new_text

	label.text = text
	visible = true
	is_visible = true
	emit_signal("popup_opened")

	# Hide after a delay
	await get_tree().create_timer(duration).timeout
	hide_popup()

func hide_popup():
	visible = false
	is_visible = false
	emit_signal("popup_closed")

# Called every frame to adjust position based on the parent
func _process(delta):
	if get_parent():
		position = get_parent().position + offset
