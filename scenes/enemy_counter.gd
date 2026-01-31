extends RichTextLabel

var default_text = "Enemies: "
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var text = str(default_text, str(Global.enemy_counter))
	self.text = text
