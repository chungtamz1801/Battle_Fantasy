extends RefCounted

class_name BattleData

var teams: Array[Team] = []

func get_team(team_id: int) -> Team:
	if(team_id > teams.size()):
		push_error("Out range of team in Battle Data")
		return null
	
	return teams[team_id]
	
func get_all_teams() -> Array[Team]:
	return teams
