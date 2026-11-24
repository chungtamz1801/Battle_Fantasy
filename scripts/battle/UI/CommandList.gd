extends HFlowContainer

signal action_selected(action_data: ActionData)
	
func add_commands(action_data: Array):
	clear_commands()
	
	for data in action_data as Array[ActionData]:
		var new_button = Button.new()
		new_button.text = data.display_name
		#size
		new_button.custom_minimum_size.x = (self.size.x - self.get_theme_constant("h_separation")) / 2
		new_button.pressed.connect(func(): action_selected.emit(data))
		self.add_child(new_button)

func clear_commands() -> void:
	for child in get_children():
		child.queue_free()
