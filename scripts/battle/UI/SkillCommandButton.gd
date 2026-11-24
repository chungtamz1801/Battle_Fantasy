extends Button

func _pressed() -> void:
	var command_list := $"../../CommandList"
	var battle_controller: BattleController = %BattleController 
	var skill_data := battle_controller.context.get_current_actor().avatar.Skills
	command_list.add_commands(skill_data)
	
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
