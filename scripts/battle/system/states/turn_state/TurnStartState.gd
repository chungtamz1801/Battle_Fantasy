extends TurnState

class_name TurnStartState

func _init(r_turn_controller: TurnController):
	super(r_turn_controller)
	self._id = TurnStateID.TURN_START

func enter():
	pass
	
func exit():
	pass
	
