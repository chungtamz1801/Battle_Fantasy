extends RefCounted

class_name AreaPatternFactory

var current_player: Player
var area_pattern_registry: Dictionary[StringName,Callable] = {}

func _init(r_battle_controller:BattleController):
	current_player = r_battle_controller.turn_controller.get_current_actor()
	r_battle_controller.turn_controller.player_changed.connect(_on_player_changed)
	register_area_patterns()
	
func _on_player_changed(
	previous_player: Player,
	current_player: Player
) -> void:
	self.current_player = current_player
	
func register_area_patterns():
	area_pattern_registry.set(&"melee_attack",func(): return SingleCircleArea.new(current_player.avatar.Position,100))
	area_pattern_registry.set(&"move",func(): return SingleCircleArea.new(current_player.avatar.Position,current_player.avatar.Move_Budget))
	
func create_area_pattern(id: String) -> AreaPattern:
	if(not area_pattern_registry.has(id)):
		push_error("ID isn't found in area pattern registry")
		return
	var creator = area_pattern_registry.get(id)
	return creator.call()
