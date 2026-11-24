extends BattleState

class_name InitializingState

func _init():
	self._id = BattleStateID.INITIALIZING

func enter(context: BattleContext):
	print("Entered INITIALIZING Battle State")
	
func exit(context: BattleContext):
	print("Exited INITIALIZING Battle State")
	
func update(context: BattleContext, delta):
	pass

func handle_input(context: BattleContext, event):
	pass
