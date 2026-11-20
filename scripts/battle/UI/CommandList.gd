extends HFlowContainer

signal action_selected(action_data: ActionData)
	
func add_command(action_data: ActionData):
	var new_button = Button.new()
		
	new_button.text = action_data.display_name
	#size
	new_button.custom_minimum_size.x = (self.size.x - self.get_theme_constant("h_separation")) / 2
	new_button.pressed.connect(func(): action_selected.emit(action_data))
	self.add_child(new_button)
