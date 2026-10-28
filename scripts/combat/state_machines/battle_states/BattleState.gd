extends Node

class_name BattleState
var machine: BattleStateMachine
var battle: BattleManager

func enter(_data: Dictionary = {}) -> void:pass
func exit() -> void:pass
func handle_input(_event: InputEvent) -> void:pass
func update(_delta: float) -> void:pass
