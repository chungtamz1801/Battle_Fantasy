extends Button

var index:int

func _ready():
	self.pressed.connect(set_player)

func set_player():
	var avatar_selection := get_tree().current_scene
	avatar_selection.set_player(index)
