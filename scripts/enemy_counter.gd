extends RichTextLabel

var counter = 0
var default_text = "Enemies: "

const HIGH_HEAT = 50
const HEAT_THRESHOLD = 10

func _ready() -> void:
	GlobalEvents.enemy_died.connect(_decrement)
	GlobalEvents.enemy_spawned.connect(_increment)
	
func _increment() -> void:
	self.counter += 1
	if self.counter >= HIGH_HEAT:
		GlobalEvents.heat_changed.emit(true)

func _decrement(_ignored: int) -> void:
	self.counter -= 1
	if self.counter <= HIGH_HEAT - HEAT_THRESHOLD:
		GlobalEvents.heat_changed.emit(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var text = str(default_text, str(counter)) 
	self.text = (text)
