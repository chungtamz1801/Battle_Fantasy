#uncheck
class_name BattleAction
extends RefCounted
## Một hành động trong trận (di chuyển, tấn công, kết thúc lượt...).
## ResolveAction gọi is_valid() rồi await execute().

var actor: Player


func _init(a: Player = null) -> void:
	actor = a


func is_valid(_battle: BattleManager) -> bool:
	return is_instance_valid(actor) and actor.is_alive()


## Có thể chứa await (animation, tween...). ResolveAction sẽ đợi xong mới đi tiếp.
func execute(_battle: BattleManager) -> void:
	pass


## true = sau hành động này lượt của actor kết thúc.
func ends_turn() -> bool:
	return false
