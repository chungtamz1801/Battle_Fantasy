extends Node

signal battle_started
signal battle_ended(result: String)

var teams: Array[Team]
var last_result: String = ""

static var turn_manager := TurnManager.new()

func _ready() -> void:
	pass
	#SaveSystem.data_readed.connect(_on_data_readed)	
	
	
