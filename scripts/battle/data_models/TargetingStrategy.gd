extends Resource

class_name TargetingStrategy

func select_target(actor: Player, mouse_position: Vector2, context: BattleContext) -> Player:
	return null

func validate(actor: Player,selection: TargetSelection,context: BattleContext) -> bool:
	return false
