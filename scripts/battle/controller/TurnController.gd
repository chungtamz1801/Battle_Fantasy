extends RefCounted
class_name TurnController

signal round_ended()
signal player_changed(previous_player: Player, current_player: Player)

var turn_order: TurnOrder = TurnOrder.new()
var current_turn_index: int = 0

func _init(players: Array[Player]) -> void:
	for player in players:
		turn_order.add_player(player)

	turn_order.sort_by_speed()

func get_current_actor() -> Player:
	return turn_order.get_player(current_turn_index)

func next_turn() -> void:
	var previous_player := get_current_actor()

	current_turn_index += 1

	if current_turn_index >= turn_order.players.size():
		current_turn_index = 0
		round_ended.emit()

	player_changed.emit(previous_player, get_current_actor())
