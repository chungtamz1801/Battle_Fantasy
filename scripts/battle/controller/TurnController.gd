extends RefCounted

class_name TurnController
var turn_order: Array[Player] = []
var current_turn_index: int = 0

func get_current_actor() -> Player:
	return turn_order[current_turn_index]

func next_turn() -> void:
	current_turn_index = ((current_turn_index + 1) % turn_order.size())
