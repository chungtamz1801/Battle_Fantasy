extends TurnState

class_name CounterTurnState

func _init(r_turn_controller: TurnController):
	super(r_turn_controller)
	self._id = TurnStateID.COUNTER_TURN

func enter():
	pass
	
func exit():
	pass
	
