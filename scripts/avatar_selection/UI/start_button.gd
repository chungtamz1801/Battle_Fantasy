extends Button


func _ready():
	self.pressed.connect(_on_pressed_test)
	
func _on_pressed():
	var root = get_tree().current_scene
	var i = 0
	for avatar_id in root.avatar_ids as Array[String]:
		if avatar_id.is_empty():
			root.show_alert("Please choose 4 avatar")
			return
		GameManager.main_team.players.append(Player.new(Config.PLAYER_NAME[i],avatar_id))
		i+=1
		
	get_tree().change_scene_to_file("res://layout/battle.tscn")
	
#test
func _on_pressed_test():
	var root = get_tree().current_scene
	var i = 0
	for avatar_id in root.avatar_ids as Array[String]:
		if avatar_id.is_empty():
			GameManager.main_team.players.append(Player.new(Config.PLAYER_NAME[i],"warrior"))
		else:
			GameManager.main_team.players.append(Player.new(Config.PLAYER_NAME[i],avatar_id))
		i+=1
		
	get_tree().change_scene_to_file("res://layout/battle.tscn")
