extends Button

func _ready():
	self.pressed.connect(_on_pressed)
	
func _on_pressed():
	var root = get_tree().current_scene
	for player:Player in root.main_team.players:
		if(player.avatar == null):
			root.show_alert("Please choose 4 avatar")
			return
	GameManager.main_team = root.main_team
	get_tree().change_scene_to_file("res://layout/battle.tscn")
