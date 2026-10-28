extends Control

var main_team := Team.new()
var current_player_id:int = 0
var count: int = 0
var alert: AcceptDialog
var avatar_ids: Array[String] = ["", "", "", "", ""]

signal avatar_changed(avatar_id: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_team.name = "Main Team"
	alert = AcceptDialog.new()
	alert.title = "Alert"
	add_child(alert)

func set_player(player_id:int):
	current_player_id = player_id
	avatar_changed.emit(avatar_ids[player_id])
	
func set_avatar(avatar_id: String):
	avatar_id = IDUtil.convert_string_into_id(avatar_id)
	avatar_ids[current_player_id] = avatar_id
	main_team.players[current_player_id].avatar = AvatarFactory.create_avatar(avatar_id)
	avatar_changed.emit(avatar_id)
	
func show_alert(message: String):
	alert.dialog_text = message
	alert.popup_centered()
	
