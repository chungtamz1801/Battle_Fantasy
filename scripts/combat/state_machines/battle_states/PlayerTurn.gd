#uncheck
extends BattleState
class_name PlayerTurn
## Lượt của đội người chơi (teams[0]).
##   Chuột trái vào đất      : di chuyển (tối đa bằng ngân sách di chuyển còn lại)
##   Chuột trái vào kẻ địch  : tấn công nếu trong tầm
##   Enter (ui_accept)       : kết thúc lượt

const MIN_MOVE := 4.0


func handle_input(event: InputEvent) -> void:
	var unit: Player = battle.active_unit
	if not is_instance_valid(unit):
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_left_click(unit)
	elif event.is_action_pressed("ui_accept"):
		_submit(EndTurnAction.new(unit))


func _on_left_click(unit: Player) -> void:
	var pos: Vector2 = battle.units_root.get_global_mouse_position()
	var target := battle.get_unit_at(pos)

	if target != null:
		if battle.are_hostile(unit, target):
			_submit(AttackAction.new(unit, target))
		return  # click vào đồng đội: bỏ qua

	if unit.move_left < MIN_MOVE:
		return
	var dest := unit.global_position.move_toward(pos, unit.move_left)  # quá xa thì cắt bớt
	if dest.distance_to(unit.global_position) < MIN_MOVE:
		return
	_submit(MoveAction.new(unit, dest))


func _submit(action: BattleAction) -> void:
	if not action.is_valid(battle):
		return  # ví dụ ngoài tầm đánh: bỏ qua, người chơi chọn lại
	machine.change_state(&"ResolveAction", {"action": action})
