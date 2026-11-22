extends RefCounted
class_name TurnOrder

var players: Array[Player] = []

func add_player(player: Player) -> void:
	players.append(player)

func sort_by_speed() -> void:
	players.sort_custom(
		func(a: Player, b: Player) -> bool:
			return a.avatar.SPD > b.avatar.SPD
	)

func get_player(index: int) -> Player:
	return players[index]
