extends ActionData

class_name RangeAttackData

@export_group("Attack")

@export var attack_range: float = 100.0
@export var damage_multiplier: float = 1.0

@export_group("Animation")

@export var animation_name: StringName = &"range_attack"
@export var hit_frame: float = 0.5

@export_group("Effects")

@export var hit_effect: PackedScene
@export var sound_effect: AudioStream
