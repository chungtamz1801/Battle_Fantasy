extends TurnState

class_name WaitingForCounterState

func _init(r_turn_controller: TurnController):
	super(r_turn_controller)
	self._id = TurnStateID.WAITING_FOR_COUNTER

func enter():
	pass
	
func exit():
	pass
	
