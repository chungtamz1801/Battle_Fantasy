extends ActionState

class_name SelectingTargetState

var action_data: ActionData
var area_pattern_factory: AreaPatternFactory
var targeting_preview: TargetingPreview


func _init(p_action_data: ActionData,r_area_pattern_factory: AreaPatternFactory,r_targeting_preview:TargetingPreview):
	action_data = p_action_data
	area_pattern_factory = r_area_pattern_factory
	targeting_preview = r_targeting_preview

func enter(context: BattleContext):
	targeting_preview.show_preview(area_pattern_factory.create_area_pattern(action_data.id))
	print(area_pattern_factory.current_player.global_position)
	
func exit(context: BattleContext):
	targeting_preview.hide_preview()
	
func update(context: BattleContext, delta):
	pass
