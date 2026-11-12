extends CharacterBody2D

class_name Player
var player_name: String
var avatar: Avatar
var team_index: int

#can change in future
#budget
var move_budget: float = 200.0
var deploy_origin: Vector2

var actions_left: int = 0
var move_left: float = 0.0

func _ready() -> void:
	avatar.Current_HP = avatar.HP
	actions_left = avatar.Max_Actions
	move_left = move_budget

# --- hiệu ứng ---
var stunned_turns: int = 0
var poison_turns: int = 0
var poison_damage: int = 1

func is_alive() -> bool:
	return avatar.Current_HP > 0

func begin_turn() -> void:
	if stunned_turns > 0:
		actions_left = 0
		move_left = 0.0
	else:
		actions_left = avatar.Max_Actions
		move_left = move_budget

func end_turn() -> void:
	if poison_turns > 0:
		take_damage(poison_damage)
		poison_turns -= 1
	if stunned_turns > 0:
		stunned_turns -= 1

## Còn làm được gì đó trong lượt (đánh hoặc đi tiếp).
func can_act() -> bool:
	return is_alive() and (actions_left > 0 or move_left >= 2.0)

func take_damage(amount: int) -> void:
	avatar.Current_HP = max(avatar.Current_HP - amount, 0)
