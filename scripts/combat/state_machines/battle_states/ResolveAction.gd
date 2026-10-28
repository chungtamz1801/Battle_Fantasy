extends BattleState

class_name ResolveAction
## Lượt của các đội AI (teams[1..]).
## AI mặc định: đánh kẻ địch gần nhất, nếu chưa tới tầm thì tiến lại gần.
## Muốn AI riêng cho từng unit: gán cho Player một biến `ai` có hàm
## choose_action(battle) -> BattleAction, state này sẽ ưu tiên dùng nó.

const MIN_MOVE := 4.0

@export var think_delay: float = 0.3


func enter(_data: Dictionary = {}) -> void:
	var unit: Player = battle.active_unit
	if think_delay > 0.0:
		await get_tree().create_timer(think_delay).timeout
	if not is_inside_tree():
		return
	machine.change_state(&"ResolveAction", {"action": _choose_action(unit)})


func _choose_action(unit: Player) -> BattleAction:
	var custom = unit.get("ai")
	if custom != null and custom.has_method("choose_action"):
		return custom.choose_action(battle)

	if unit.actions_left <= 0:
		return EndTurnAction.new(unit)

	var target := battle.get_nearest_enemy(unit)
	if target == null:
		return EndTurnAction.new(unit)

	if battle.is_in_range(unit, target, unit.attack_range):
		return AttackAction.new(unit, target)

	if unit.move_left >= MIN_MOVE:
		var dist := battle.distance_between(unit, target)
		var stop_at := maxf(unit.attack_range - 4.0, 0.0)  # dừng ngay trong tầm đánh
		var step := minf(dist - stop_at, unit.move_left)
		if step >= MIN_MOVE:
			var dest := unit.global_position.move_toward(target.global_position, step)
			return MoveAction.new(unit, dest)

	return EndTurnAction.new(unit)
