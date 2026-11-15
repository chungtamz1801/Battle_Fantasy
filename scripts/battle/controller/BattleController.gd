extends Node

class_name BattleController

enum TurnStateMachine{
	TURN_START,
	TURN_START_PROCESSING,
	PLAYER_TURN,
	TURN_END,
	TURN_END_PROCESSING
}

var battle_fsm: BattleStateMachine
var turn_controller: TurnController
var command_factory: CommandFactory
var context: BattleContext

func _ready() -> void:
	initialize_battle()
	
func _process(delta: float) -> void:
	pass

func initialize_battle() -> void:
	turn_controller = TurnController.new()
	command_factory = CommandFactory.new()

	context = BattleContext.new(
		[],
		turn_controller,
		command_factory
	)

	battle_fsm = BattleStateMachine.new(context)
