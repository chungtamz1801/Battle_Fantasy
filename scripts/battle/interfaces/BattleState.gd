extends RefCounted

class_name BattleState

enum BattleStateID {
	INITIALIZING,
	STARTING,
	RUNNING,
	PAUSED,
	FINISHED
}

var id:BattleStateID:
	get: return _id

var _id: BattleStateID

func enter(context: BattleContext):
	pass
	
func exit(context: BattleContext):
	pass
	
func update(context: BattleContext, delta):
	pass

func handle_input(context: BattleContext, event):
	pass
