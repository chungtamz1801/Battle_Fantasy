extends Node2D

var previous_time: int = 0

@onready var battle_controller:BattleController = $"BattleController"
@onready var teams_node: Node = $"Teams"

func _ready() -> void:
	set_up_main_team()

func _process(_delta: float) -> void:
	var current_time := Time.get_ticks_msec()

	if previous_time != 0:
		var frame_time := current_time - previous_time

		if frame_time > 50:
			print("Frame took: ", frame_time, " ms")

	previous_time = current_time

func set_up_main_team():
	var team_node: Node = Node.new()
	var index := 1 
	for player in GameManager.main_team.players:
		var player_node: CharacterBody2D = CharacterBody2D.new()
		player_node.add_child(player.avatar.Sprite)
		player_node.position = Vector2(500,index*300)
		team_node.add_child(player_node)
		index+=1
		
	teams_node.add_child(team_node)
