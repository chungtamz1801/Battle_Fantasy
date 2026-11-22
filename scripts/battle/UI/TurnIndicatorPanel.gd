extends Node

@onready var battle_controller:BattleController = %BattleController

func _ready():
	if not battle_controller.is_node_ready():
		await battle_controller.ready

	var turn_controller = battle_controller.turn_controller

	turn_controller.turn_order_updated.connect(_update_turn_indicator)
	_update_turn_indicator(turn_controller.turn_order.players)

func _update_turn_indicator(players:Array[Player]):
	var data: Array[String] = []
	for player in players:
		data.append(player.player_name)
	UIUtil.load_box_horizontal_UI(self,data,100.0)
