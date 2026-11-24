extends CharacterBody2D

class_name Player
var player_name: String
var avatar: Avatar
var team: Team

func _init(p_player_name: String,avatar_id: String):
	player_name = p_player_name
	avatar = AvatarFactory.create_avatar(avatar_id)
	avatar.Current_HP = avatar.HP
	avatar.AP_Left = avatar.Max_AP
	self.add_child(load_sprite_by_id(p_player_name,avatar_id))

static func load_sprite_by_id(player_name:String,avatar_id: String) -> Sprite2D:
	var sprite = Sprite2D.new()
	var sprite_path := "spr_main_%s_idle" % avatar_id
	if(player_name.contains("Enemy")):
		sprite_path = "spr_enemy_%s_idle" % avatar_id
	sprite.texture = load("res://sprites/avatars/%s/%s.png" % [sprite_path,sprite_path+"_0"])
	sprite.scale = Vector2(2,2)
	return sprite
## --- hiệu ứng ---
#var stunned_turns: int = 0
#var poison_turns: int = 0
#var poison_damage: int = 1
#
#func is_alive() -> bool:
	#return avatar.Current_HP > 0
#
#func begin_turn() -> void:
	#if stunned_turns > 0:
		#actions_left = 0
		#move_left = 0.0
	#else:
		#actions_left = avatar.Max_Actions
		#move_left = move_budget
#
#func end_turn() -> void:
	#if poison_turns > 0:
		#take_damage(poison_damage)
		#poison_turns -= 1
	#if stunned_turns > 0:
		#stunned_turns -= 1
#
### Còn làm được gì đó trong lượt (đánh hoặc đi tiếp).
#func can_act() -> bool:
	#return is_alive() and (actions_left > 0 or move_left >= 2.0)
#
#func take_damage(amount: int) -> void:
	#avatar.Current_HP = max(avatar.Current_HP - amount, 0)
