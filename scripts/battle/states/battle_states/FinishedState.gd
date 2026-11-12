extends BattleState

class_name FinishedState

func _init():
	self._id = BattleStateID.FINISHED

func enter(context: BattleContext):
	pass
	
func exit(context: BattleContext):
	pass
	
func update(context: BattleContext, delta):
	pass

func handle_input(context: BattleContext, event):
	pass
