#uncheck

class_name BattleStateMachine
extends Node
## Quản lý state của trận. Mỗi state là một node con (script extends BattleState).
## Tên NODE phải khớp với tên dùng trong change_state(), ví dụ &"TurnStart".

signal state_changed(old_name: StringName, new_name: StringName)

## Kéo node state đầu tiên (Setup) vào đây trong Inspector.
@export var initial_state: BattleState

var current: BattleState
var states: Dictionary = {}


func init(battle: BattleManager) -> void:
	for child in get_children():
		if child is BattleState:
			child.machine = self
			child.battle = battle
			states[child.name] = child
	if initial_state == null:
		push_error("BattleStateMachine: chưa gán initial_state")
		return
	change_state(initial_state.name)


func change_state(state_name: StringName, data: Dictionary = {}) -> void:
	if not states.has(state_name):
		push_error("BattleStateMachine: không có state '%s'" % state_name)
		return
	var old_name: StringName = current.name if current != null else &""
	if current != null:
		current.exit()
	current = states[state_name]
	state_changed.emit(old_name, state_name)
	current.enter(data)


func _unhandled_input(event: InputEvent) -> void:
	if current != null:
		current.handle_input(event)


func _process(delta: float) -> void:
	if current != null:
		current.update(delta)
