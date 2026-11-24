extends RefCounted

class_name TargetingStrategy

signal targeting_done(action_request: ActionRequest)

var target_result_mode: int
var target_category: int
var targeting_area: Area2D
var action_request: ActionRequest
var is_valid: bool = true

func update(mouse_position: Vector2):
	pass

func draw_area(canvas: Node2D):
	pass

func create_action_request(actor: Player):
	pass
	
func is_redraw_required()->bool:
	return false
	
func _on_area_entered(object: Node2D) -> void:
	var flag = TargetCategory.POSITION
	if object is Player:
		if object.team.team_type == Team.TeamType.MAIN:
			flag = TargetCategory.ALLY
		elif object.team.team_type == Team.TeamType.ENEMY:
			flag = TargetCategory.ENEMY
	is_valid = target_category == flag

func _on_area_exited(body: Node2D) -> void:
	is_valid = target_category == TargetCategory.POSITION
