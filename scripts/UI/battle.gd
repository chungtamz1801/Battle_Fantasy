extends Node2D

var previous_time: int = 0
@onready var main_team_node = $"BattleField/MainTeam"

func _ready() -> void:
	set_up_players()
	

func _process(_delta: float) -> void:
	var current_time := Time.get_ticks_msec()

	if previous_time != 0:
		var frame_time := current_time - previous_time

		if frame_time > 50:
			print("Frame took: ", frame_time, " ms")

	previous_time = current_time

func set_up_players():
	var index := 1 
	for player in GameManager.main_team.players:
		var player_node: Node2D = Node2D.new()
		var sprite = Sprite2D.new()
		var sprite_path := "spr_main_%s_idle" % player.player_avatar.to_lower().replace(" ","_")
		sprite.texture = load("res://sprites/avatars/%s/%s.png" % [sprite_path,sprite_path+"_0"])
		sprite.scale = Vector2(2,2)
		player_node.add_child(sprite)
		player_node.position = Vector2(500,index*300)
		
		main_team_node.add_child(player_node)
		
		index+=1
