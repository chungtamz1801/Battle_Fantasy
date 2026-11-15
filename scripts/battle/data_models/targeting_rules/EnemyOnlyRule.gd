extends TargetingRule

class_name EnemyOnlyRule

func is_valid(actor: Player, selection: TargetSelection, context: BattleContext) -> bool:
	#if(check_enemy(actor,selection.targets[0])):
		#return true
	return false
