extends RefCounted

class_name ActionFactory
var action_registry: Dictionary[String,Action] = {}

func _init():
	register_actions()
	
func register_actions():
	action_registry.set("melee_attack",MeleeAttack.new())
	
func create_action(id: String) -> Action:
	if(not action_registry.has(id)):
		push_error("ID isn't found in action registry")
		return
	return action_registry.get(id)
