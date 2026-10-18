extends Resource

class_name Team
var name: String
var players: Array[Player]

func _init() -> void:
	for i in range(GameManager.team_size):
		players.append(Player.new())
