extends RefCounted

class_name TurnController

signal player_changed(previous_player: Player, current_player: Player)

var turn_order: Array[int] = []
var current_turn_index: int = 0

func _init(teams: Array[Team]):
	for team in teams:
		for player in team.players:
			turn_order.append(player)
	turn_order.sort_custom(
		func(a: Player, b:Player) -> bool:
			return a.avatar.SPD > b.avatar.SPD
	)

func get_current_actor() -> int:
	return current_turn_index

func next_turn() -> void:
	var previous_player := turn_order[current_turn_index]
	current_turn_index = ((current_turn_index + 1) % turn_order.size())
	player_changed.emit(previous_player, turn_order[current_turn_index])
	
