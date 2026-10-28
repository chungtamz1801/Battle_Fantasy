#uncheck
extends BattleState
class_name TurnEnd
## Cuối lượt: tick hiệu ứng (độc, choáng...), dọn unit chết, kiểm tra thắng/thua.

func enter(_data: Dictionary = {}) -> void:
	var unit: Player = battle.active_unit
	if is_instance_valid(unit) and unit.is_alive():
		unit.end_turn()
		if not unit.is_alive():  # chết vì độc
			battle.remove_unit(unit)
			unit.queue_free()

	await get_tree().create_timer(0.1).timeout
	if not is_inside_tree():
		return

	if battle.check_victory():
		machine.change_state(&"BattleEnd", {"result": BattleManager.VICTORY})
	elif battle.check_defeat():
		machine.change_state(&"BattleEnd", {"result": BattleManager.DEFEAT})
	else:
		machine.change_state(&"TurnStart")
