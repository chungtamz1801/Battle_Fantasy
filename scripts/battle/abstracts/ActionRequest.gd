extends RefCounted
class_name ActionRequest

var actor: Player
var target: Variant

func _init(p_player: Player):
	actor = p_player
