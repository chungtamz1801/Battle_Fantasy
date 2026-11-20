extends RefCounted

class_name ActionStateMachine

var context: BattleContext
var current_state: ActionState

#var state_registry: Dictionary = {
	#ActionState.ActionStateID.SELECTING_ACTION: SelectingActionState,
	#ActionState.ActionStateID.SELECTING_TARGET: SelectingTargetState,
	#ActionState.ActionStateID.EXECUTING_ACTION: ExecutingActionState,
	#ActionState.ActionStateID.RESOLVING_EFFECTS: ResolvingEffectsState,
#}

func _init(initial_state: ActionState,context: BattleContext):
	self.current_state = initial_state
	self.context = context

func change_state(state: ActionState):
	if current_state != null:
		current_state.exit(context)

	current_state = state
	current_state.enter(context)

func update(delta):
	if current_state == null:
		return
	current_state.update(context, delta)
	

 
