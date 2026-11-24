extends BattleState

class_name RunningState

func _init():
	self._id = BattleStateID.RUNNING

func enter(context: BattleContext):
	pass
	
func exit(context: BattleContext):
	pass
	
func update(context: BattleContext, delta):
	pass

func handle_input(context: BattleContext, event):
	pass
