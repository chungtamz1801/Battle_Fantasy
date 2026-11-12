extends Node

class_name Team
var team_name: String
var players: Array[Player]

func _init() -> void:
	for i in range(GameManager.team_size):
		players.append(Player.new())
