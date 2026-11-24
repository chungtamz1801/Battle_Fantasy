extends ActionState

class_name SelectingTargetState

var action_data: ActionData
var targeting_strategy_factory: TargetingStrategyFactory
var targeting_strategy: TargetingStrategy
var targeting_preview: TargetingPreview


func _init(p_action_data: ActionData,r_targeting_strategy_factory: TargetingStrategyFactory,r_targeting_preview:TargetingPreview):
	action_data = p_action_data
	targeting_strategy_factory = r_targeting_strategy_factory
	targeting_preview = r_targeting_preview

func enter(context: BattleContext):
	targeting_strategy = targeting_strategy_factory.create_targeting_strategy(action_data.id)
	targeting_preview.show_preview(targeting_strategy)
	
func exit(context: BattleContext):
	targeting_preview.hide_preview()
	
func update(context: BattleContext, delta):
	targeting_preview.update_preview()
	
func handle_input(event: InputEvent, context: BattleContext) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			targeting_strategy.create_action_request(context.get_current_actor())
