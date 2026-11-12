extends Node

enum BattleStateMachine {
	INITIALIZING,
	STARTING,
	RUNNING,
	PAUSED,
	FINISHED
}

enum TurnStateMachine{
	TURN_START,
	TURN_START_PROCESSING,
	PLAYER_TURN,
	TURN_END,
	TURN_END_PROCESSING
}

enum ActionStateMachine{
	SELECTING_ACTION,
	SELECTING_TARGET,
	VALIDATING_ACTION,
	EXECUTING_ACTION,
	RESOLVING_EFFECTS,
	ACTION_COMPLETED
}

var teams: Array[Team] = []
var commandQueue: Array[Command] = []

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
