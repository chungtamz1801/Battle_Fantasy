extends RefCounted
class_name TurnController

signal round_ended()
signal player_changed(previous_player: Player, current_player: Player)
signal turn_order_updated(new_turn_order: Array[Player])

var turn_order: TurnOrder = TurnOrder.new()
var current_turn_index: int = 0
var turn_fsm: TurnStateMachine
var is_require_updating_turn_order: bool = true

func _init() -> void:
	turn_fsm = TurnStateMachine.new(self)

func next_turn() -> void:
	var previous_player := turn_order.get_player(current_turn_index)

	current_turn_index += 1

	if current_turn_index >= turn_order.players.size(): 
		current_turn_index = 0
		round_ended.emit()

	player_changed.emit(previous_player, turn_order.get_player(current_turn_index))

func on_new_player_added(players: Array[Player]):
	for player in players:
		turn_order.add_player(player)
	is_require_updating_turn_order = true
	if turn_fsm.current_state is RoundStartState:
		turn_fsm.current_state.enter()
