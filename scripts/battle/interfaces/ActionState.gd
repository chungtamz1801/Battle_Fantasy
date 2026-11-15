extends RefCounted

class_name ActionState

enum ActionStateID {
	SELECTING_ACTION,
	SELECTING_TARGET,
	EXECUTING_ACTION,
	RESOLVING_EFFECTS,
}

var id:ActionStateID:
	get: return _id

var _id: ActionStateID

func enter(context: BattleContext):
	pass
	
func exit(context: BattleContext):
	pass
	
func update(context: BattleContext, delta):
	pass
