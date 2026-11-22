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
var area_pattern_factory: AreaPatternFactory
var action_fsm: ActionStateMachine
var targeting_preview: TargetingPreview

func _ready() -> void:
	initialize_battle()
	
func _process(delta: float) -> void:
	action_fsm.update(delta)
	pass

func initialize_battle() -> void:
	var command_list := %CommandList
	targeting_preview = %TargetingPreview
	command_list.action_selected.connect(_on_action_selected)
	
	turn_controller = TurnController.new(GameManager.main_team.players)
	
	context = BattleContext.new(turn_controller,command_factory)
	context.add_players(GameManager.main_team.players)
	
	command_factory = CommandFactory.new()
	area_pattern_factory = AreaPatternFactory.new(self)

	

	battle_fsm = BattleStateMachine.new(context)
	action_fsm = ActionStateMachine.new(SelectingActionState.new(),context)
	
func _on_action_selected(action_data: ActionData):
	action_fsm.change_state(SelectingTargetState.new(action_data,area_pattern_factory,targeting_preview))
