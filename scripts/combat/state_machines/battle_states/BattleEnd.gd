#uncheck
extends BattleState
class_name BattleEnd
## Kết thúc trận: báo kết quả ra ngoài qua BattleManager.battle_finished.

@export var end_delay: float = 0.8


func enter(data: Dictionary = {}) -> void:
	var result: String = data.get("result", BattleManager.DEFEAT)
	await get_tree().create_timer(end_delay).timeout
	if not is_inside_tree():
		return
	battle.finish(result)
