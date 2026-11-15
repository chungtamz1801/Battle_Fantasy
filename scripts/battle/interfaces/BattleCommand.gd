extends RefCounted

class_name BattleCommand

var request: ActionRequest

func _init(p_request: ActionRequest) -> void:
	request = p_request

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
	return true


func execute_action(context: BattleContext) -> void:
	push_error("execute_action() must be implemented by subclass")
