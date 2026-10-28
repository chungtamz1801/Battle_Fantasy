#uncheck
extends BattleState
class_name TurnStart
## Lấy unit kế tiếp từ TurnQueue và chuyển sang PlayerTurn / AITurn.

@export var pause: float = 0.25  # nhịp nghỉ đầu lượt (camera, UI)


func enter(_data: Dictionary = {}) -> void:
	var unit := battle.turn_queue.next_unit()
	if unit == null:
		var result := BattleManager.VICTORY if battle.check_victory() else BattleManager.DEFEAT
		machine.change_state(&"BattleEnd", {"result": result})
		return

	battle.start_turn_of(unit)  # reset điểm hành động, phát signal turn_changed

	if pause > 0.0:
		await get_tree().create_timer(pause).timeout
	if not is_inside_tree():
		return

	if not unit.can_act():  # ví dụ bị choáng
		machine.change_state(&"TurnEnd")
	elif battle.is_player_controlled(unit):
		machine.change_state(&"PlayerTurn")
	else:
		machine.change_state(&"AITurn")
