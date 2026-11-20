extends RefCounted

class_name BattleContext

var teams: Array[Team]
var command_factory: CommandFactory
var turn_controller: TurnController
#Them sau
#var action_stack: ActionStack

func _init(teams: Array[Team],turn_controller:TurnController, command_factory: CommandFactory):
	self.teams = teams
	self.turn_controller = turn_controller
	self.command_factory = command_factory
	
func get_all_player() -> Array[Player]:
	var player_list: Array[Player] = []
	for team in teams:
		for player in team.players:
			player_list.append(player)
	return player_list
