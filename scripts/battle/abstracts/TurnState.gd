extends RefCounted

class_name TurnState

enum TurnStateID {
	ROUND_START,
	ROUND_END,
	TURN_START,
	TURN_END,
	WAITING_FOR_COUNTER,
	COUNTER_TURN
}

var id:TurnStateID:
	get: return _id

var _id: TurnStateID
var turn_controller: TurnController

func _init(r_turn_controller):
	turn_controller = r_turn_controller

func enter():
	pass
	
func exit():
	pass
	
