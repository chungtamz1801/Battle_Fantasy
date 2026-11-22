extends RefCounted

class_name BattleStateMachine

var context: BattleContext
const initial_state_id = BattleState.BattleStateID.INITIALIZING
var current_state: BattleState

var state_registry: Dictionary = {
	BattleState.BattleStateID.INITIALIZING: InitializingState,
	BattleState.BattleStateID.STARTING: StartingState,
	BattleState.BattleStateID.RUNNING: RunningState,
	BattleState.BattleStateID.PAUSED: PausedState,
	BattleState.BattleStateID.FINISHED: FinishedState
}

func _init(context: BattleContext):
	self.current_state = state_registry[initial_state_id].new()
	self.context = context

func change_state(state_id:BattleState.BattleStateID):
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
	
func handle_input(event):
	if current_state == null:
		return
	current_state.update(context, event)
 
