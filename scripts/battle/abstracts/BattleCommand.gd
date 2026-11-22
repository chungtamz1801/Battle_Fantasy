extends RefCounted

class_name BattleCommand

enum CommandType{
	MOVE_COMMAND,
	ATTACK_COMMAND,
	SKILL_COMMAND,
	COMMON_COMMAND
}

var request: ActionRequest
var command_type: CommandType

func _init(p_request: ActionRequest, p_command_type: CommandType) -> void:
	request = p_request
	command_type = p_command_type

func execute(context: BattleContext) -> void:
	if not can_execute():
		return

	if not consume_resources():
		return

	execute_action(context)


func can_execute() -> bool:
	# Kiểm tra actor còn sống, đủ điều kiện thực hiện...
	return true

func consume_resources() -> bool:
	if(command_type == CommandType.MOVE_COMMAND):
		var move_cost := request.actor.global_position.distance_to(request.target)
		request.actor.avatar.Move_Budget -= move_cost
	return true


func execute_action(context: BattleContext) -> void:
	push_error("execute_action() must be implemented by subclass")
