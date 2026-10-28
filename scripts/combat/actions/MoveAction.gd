#uncheck
class_name MoveAction
extends BattleAction
## Di chuyển tự do tới một vị trí, trừ vào ngân sách di chuyển (move_left).
## Chưa có pathfinding/va chạm: unit đi thẳng tới đích.

const MOVE_SPEED := 320.0  # pixel/giây, chỉ ảnh hưởng animation

var destination: Vector2


func _init(a: Player = null, dest: Vector2 = Vector2.ZERO) -> void:
	super(a)
	destination = dest


func is_valid(battle: BattleManager) -> bool:
	if not super(battle):
		return false
	return actor.global_position.distance_to(destination) <= actor.move_left + 0.01


func execute(_battle: BattleManager) -> void:
	var distance := actor.global_position.distance_to(destination)
	actor.move_left = maxf(actor.move_left - distance, 0.0)
	var tween := actor.create_tween()
	tween.tween_property(actor, "global_position", destination, distance / MOVE_SPEED)
	await tween.finished
