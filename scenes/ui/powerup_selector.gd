extends VBoxContainer

signal menu_opened();
signal menu_closed();


func set_selector(selectableItems: Array, on_select: Callable) -> void:
	#Show items
	var select_index = 0;
	for item in selectableItems:
		var button_pressed = func ():
			#Call cb
			on_select.call(select_index)
			#Clear items
			for child in get_children():
				remove_child(child)
				
			self.menu_closed
			visible = false
			
			get_tree().paused = false
			
		var select_button = Button.new()
		select_button.pressed.connect(button_pressed)
		
		if item.has_method("get_item_name"):
			select_button.text = item.get_item_name()
		else:
			select_button.text = "NULL get_item_name()"

		add_child(select_button)
		select_index += 1

	self.menu_opened
	visible = true
	get_tree().paused = true
	
