extends Button

func _pressed() -> void:
	var command_list := $"../../CommandList"
	
	for child in command_list.get_children():
		child.queue_free()
	
	var move_data = load("res://data/tres/actions/commons/MoveData.tres")
	command_list.add_command(move_data as MoveData)
	
	#new_button = Button.new()
	#new_button.text = "Rank Up"
	##size
	#new_button.custom_minimum_size.x = (command_list.size.x - separation) / 2
	#new_button.pressed.connect(func(): print("Rank Up"))
	#command_list.add_child(new_button)
	
	#new_button = Button.new()
	#new_button.text = "Surrender"
	#new_button.custom_minimum_size.x = (command_list.size.x - separation) / 2
	#new_button.pressed.connect(func(): print("Surrender"))
	#command_list.add_child(new_button)
