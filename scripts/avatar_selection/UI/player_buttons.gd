extends HBoxContainer

@onready var root = get_tree().current_scene

func _ready() -> void:
	root.avatar_changed.connect(_on_avatar_changed)
	load_player_selection_button()

func _on_avatar_changed(avatar_id: String):
	var index: int = root.current_player_id
	var player_button = get_node("PlayerButton%d" % index)
	player_button.text = "Player %s\nAvatar: %s" % [(index + 1),GameManager.avatar_repo.get_avatar_name_by_id(avatar_id)]
	
func load_player_selection_button():
	for index in range(GameManager.team_size):
		var player_button = Button.new()
		player_button.text = "Player %s\nAvatar: None" % (index + 1)
		player_button.set_script(load("res://scripts/UI/player_selection_button.gd"))
		player_button.name = "PlayerButton%d" % index
		player_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		player_button.size_flags_stretch_ratio = 0.2
		player_button.index = index
		self.add_child(player_button)
	
	
