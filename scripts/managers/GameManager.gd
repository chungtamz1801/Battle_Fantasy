extends Node

var team_size: int = 5
var main_team := Team.new(Team.TeamType.MAIN)
var other_teams:Array[Team] = []
var avatar_repo := AvatarRepo.new()
