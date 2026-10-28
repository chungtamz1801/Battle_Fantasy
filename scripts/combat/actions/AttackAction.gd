#uncheck

class_name AttackAction
extends BattleAction
## Tấn công một mục tiêu trong tầm. Tốn 1 điểm hành động.

var target: Player


func _init(a: Player = null, t: Player = null) -> void:
	super(a)
	target = t


func is_valid(battle: BattleManager) -> bool:
	if not super(battle):
		return false
	if actor.actions_left <= 0:
		return false
	if not is_instance_valid(target) or not target.is_alive():
		return false
	if not battle.are_hostile(actor, target):
		return false
	return battle.is_in_range(actor, target, actor.attack_range)


func execute(battle: BattleManager) -> void:
	actor.actions_left -= 1
	target.take_damage(actor.attack_power)

	# nháy đỏ khi trúng đòn
	var flash := target.create_tween()
	flash.tween_property(target, "modulate", Color(1.0, 0.3, 0.3), 0.08)
	flash.tween_property(target, "modulate", Color.WHITE, 0.12)
	await flash.finished

	if not target.is_alive():
		battle.remove_unit(target)
		var fade := target.create_tween()
		fade.tween_property(target, "modulate:a", 0.0, 0.3)
		await fade.finished
		target.queue_free()
