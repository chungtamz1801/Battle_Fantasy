extends RefCounted

class_name ActionStateMachine

var context: BattleContext
const initial_state_id = ActionState.ActionStateID.SELECTING_ACTION
var current_state: BattleState

var state_registry: Dictionary = {
	ActionState.ActionStateID.SELECTING_ACTION: SelectingActionState,
	ActionState.ActionStateID.SELECTING_TARGET: SelectingTargetState,
	ActionState.ActionStateID.EXECUTING_ACTION: ExecutingActionState,
	ActionState.ActionStateID.RESOLVING_EFFECTS: ResolvingEffectsState,
}

func _init(context: BattleContext):
	self.current_state = state_registry[initial_state_id].new()
	self.context = context

func change_state(state_id:ActionState.ActionStateID):
	if not state_registry.has(state_id):
		push_error("Invalid State ID")
		return

	if current_state != null:
		current_state.exit(context)

	var state_script: Script = state_registry[state_id]
	current_state = state_script.new()
	current_state.enter(context)

func update(delta):
	if current_state == null:
		return
	current_state.update(context, delta)
	

 
