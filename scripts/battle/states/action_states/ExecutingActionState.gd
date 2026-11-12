extends ActionState

class_name ExecutingActionState

func _init():
	self._id = ActionStateID.EXECUTING_ACTION

func enter(context: BattleContext):
	pass
	
func exit(context: BattleContext):
	pass
	
func update(context: BattleContext, delta):
	pass
