extends TurnState

class_name TurnEndState

func _init(r_turn_controller: TurnController):
	super(r_turn_controller)
	self._id = TurnStateID.TURN_END

func enter():
	pass
	
func exit():
	pass
	
