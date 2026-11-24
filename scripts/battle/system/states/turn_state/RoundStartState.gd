extends TurnState

class_name RoundStartState

func _init(r_turn_controller: TurnController):
	super(r_turn_controller)
	self._id = TurnStateID.ROUND_START

func enter():
	if turn_controller.is_require_updating_turn_order:
		update_turn_order()
	
func exit():
	pass
	
func update_turn_order():
	turn_controller.turn_order.sort_by_speed()
	turn_controller.is_require_updating_turn_order = false
	turn_controller.turn_order_updated.emit(turn_controller.turn_order.players)
