extends RefCounted

class_name Team

enum TeamType{
	MAIN,
	ENEMY
}

var team_type: TeamType
var players: Array[Player]

func _init(p_team_type: TeamType):
	team_type = p_team_type
