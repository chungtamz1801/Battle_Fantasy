extends Resource

class_name ActionData

enum ActionType{
	ATTACK,
	SKILL,
	MOVE,
	USING_ITEM
}

@export var id: StringName
@export var display_name: String
@export_multiline var description: String
@export var targeting_data: TargetingData
@export var action_type: ActionType
