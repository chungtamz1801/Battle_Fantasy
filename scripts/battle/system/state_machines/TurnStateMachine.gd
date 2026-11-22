extends RefCounted

class_name TurnStateMachine

const initial_state_id = TurnState.TurnStateID.ROUND_START
var current_state: TurnState
var turn_controller: TurnController

var state_registry: Dictionary = {
	TurnState.TurnStateID.ROUND_START: RoundStartState,
	TurnState.TurnStateID.ROUND_END: RoundEndState,
	TurnState.TurnStateID.TURN_START: TurnStartState,
	TurnState.TurnStateID.TURN_END: TurnEndState,
	TurnState.TurnStateID.WAITING_FOR_COUNTER: WaitingForCounterState,
	TurnState.TurnStateID.COUNTER_TURN: CounterTurnState
}

func _init(r_turn_controller: TurnController):
	self.current_state = state_registry[initial_state_id].new(r_turn_controller)
	current_state.enter()
	

func change_state(state_id:TurnState.TurnStateID):
	if not state_registry.has(state_id):
		push_error("Invalid State ID")
		return

	if current_state != null:
		current_state.exit()

	var state_script: Script = state_registry[state_id]
	current_state = state_script.new()
	current_state.enter()
