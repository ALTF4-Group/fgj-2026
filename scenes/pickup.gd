extends Area2D
class_name Pickup

@export var hud : HUD;
@export var selectableItems = [TestItem.new()];

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)


static func from_args(selectableItems) -> Pickup:
	var pickup = Pickup.new()
	pickup.selectableItems.append_array(selectableItems)
	return pickup
	

func _on_body_entered(other:Node2D) -> void:
	if other.name != "Player":
		return
	
	var selector = hud.PowerupSelector
	var cleanup = func(selected_index: int) -> void:
		var selected_item = self.selectableItems[selected_index]
		if selected_item != null and selected_item.has_method("apply"):
			selected_item.apply(other)
		queue_free()
		
	selector.set_selector(self.selectableItems, cleanup)
