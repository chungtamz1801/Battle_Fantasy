extends RefCounted

class_name CommandFactory
var command_registry: Dictionary[String,Callable] = {}

func _init():
	setup_commands()
	
func setup_commands():
	register_command(&"melee_attack",MeleeAttackCommand)
	
func register_command(id:String, command:Script):
	command_registry.set(id,func(request:ActionRequest): return command.new(request))
	
func create_command(id: String, request: ActionRequest) -> BattleCommand:
	if(not command_registry.has(id)):
		push_error("ID isn't found in action registry")
		return
	var creator = command_registry.get(id)
	return creator.call(request)
