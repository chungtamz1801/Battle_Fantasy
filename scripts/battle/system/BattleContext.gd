extends RefCounted

class_name BattleContext

signal new_players_added(players:Array[Player])

var players: Array[Player] = []
#var teams: Array[Team]
var command_factory: CommandFactory
var turn_controller: TurnController

func _init(turn_controller:TurnController, command_factory: CommandFactory):
	self.turn_controller = turn_controller
	self.command_factory = command_factory
	
func get_all_player() -> Array[Player]:
	return players
	
func add_players(r_players: Array[Player]):
	players.append_array(r_players)
	new_players_added.emit(r_players)

func get_current_actor() -> Player:
	return turn_controller.turn_order.get_player(turn_controller.current_turn_index)
