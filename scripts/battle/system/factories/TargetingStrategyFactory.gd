extends RefCounted

class_name TargetingStrategyFactory

var current_player: Player
var targeting_strategy_registry: Dictionary[StringName,Callable] = {}

func _init(r_battle_controller:BattleController):
	current_player = r_battle_controller.context.get_current_actor()
	r_battle_controller.turn_controller.player_changed.connect(_on_player_changed)
	register_targeting_strategis()
	
func _on_player_changed(
	previous_player: Player,
	current_player: Player
) -> void:
	self.current_player = current_player
	
func register_targeting_strategis():
	targeting_strategy_registry.set(&"melee_attack",func(): 
		return SingleCirclePositionTargetingStrategy.new(100,current_player.global_position))
	targeting_strategy_registry.set(&"move",func(): 
		return SingleCirclePositionTargetingStrategy.new(current_player.avatar.Move_Budget,current_player.global_position))
	
func create_targeting_strategy(id: String) -> TargetingStrategy:
	if(not targeting_strategy_registry.has(id)):
		push_error("ID isn't found in area pattern registry")
		return
	var creator = targeting_strategy_registry.get(id)
	return creator.call()
