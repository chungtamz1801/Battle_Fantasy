extends Node

class_name BattleStateMachine

signal state_changed(old_name: StringName, new_name: StringName)

@export var initial_state: NodePath
var current: BattleState
var states: Dictionary = {}

func init(battle:Node) -> void:
	for child in get_children():
		if child is BattleState:
			child.machine = self
			child.battle = battle
			states[child.name] = child
	change_state(get_node(initial_state).name)
	
func change_state(state_name: StringName, data: Dictionary = {}) -> void:
	if not states.has(state_name):
		push_error("State doesn't exsist")
		return
	var old_name: StringName = current.name if current else &""
	if current:
		current.exit()
	current = states[state_name]
	current.enter(data)
	state_changed.emit(old_name,state_name)
	
func _unhandled_input(event: InputEvent) -> void:
	if current:
		current.handle_input(event)

func _process(delta: float) -> void:
	if current:
		current.update(delta)
	
