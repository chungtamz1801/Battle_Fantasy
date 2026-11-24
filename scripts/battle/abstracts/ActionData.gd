extends Resource

class_name ActionData

enum ActionType{
	ATTACK,
	SKILL,
	MOVE,
	USING_ITEM
}

@export_group("Info")
@export var id: StringName
@export var display_name: String
@export var ap_cost: int
@export_multiline var description: String
@export var action_area: ActionArea
@export var action_type: ActionType

@export_group("Animation")

@export var animation_name: StringName = &"magic_attack"
@export var hit_frame: float = 0.5

@export_group("Effects")

@export var hit_effect: PackedScene
@export var sound_effect: AudioStream
