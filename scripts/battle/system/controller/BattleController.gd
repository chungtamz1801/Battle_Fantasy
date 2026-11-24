extends Node

class_name BattleController

var battle_fsm: BattleStateMachine
var turn_controller: TurnController
var command_factory: CommandFactory
var context: BattleContext
var targeting_strategy_factory: TargetingStrategyFactory
var action_fsm: ActionStateMachine
var targeting_preview: TargetingPreview


func _ready() -> void:
	initialize_battle()
	
func _process(delta: float) -> void:
	action_fsm.update(delta)
	
func _input(event: InputEvent):
	action_fsm.current_state.handle_input(event, context)

func initialize_battle() -> void:
	var command_list := %CommandList
	targeting_preview = %TargetingPreview
	command_list.action_selected.connect(_on_action_selected)
	
	turn_controller = TurnController.new()
	
	context = BattleContext.new(turn_controller,command_factory)
	context.new_players_added.connect(turn_controller.on_new_player_added)
	
	context.add_players(GameManager.main_team.players)
	context.add_players(GameManager.other_teams[0].players)
	
	command_factory = CommandFactory.new()
	targeting_strategy_factory = TargetingStrategyFactory.new(self)

	battle_fsm = BattleStateMachine.new(context)
	action_fsm = ActionStateMachine.new(SelectingActionState.new(),context)
	


func _on_action_selected(action_data: ActionData):
	action_fsm.change_state(SelectingTargetState.new(action_data,targeting_strategy_factory,targeting_preview))
