#uncheck
class_name BattleManager
extends Node
## Bộ nhớ chung + hàm tiện ích của MỘT trận đấu.
## - Không quyết định luồng (việc của các BattleState)
## - Không tính damage / animation (việc của BattleAction / Player)
## - Không chứa logic AI (AI chỉ HỎI BattleManager)

const VICTORY := "Victory"
const DEFEAT := "Defeat"

signal round_started(round_number: int)
signal turn_changed(unit: Player)
signal unit_died(unit: Player)
signal battle_finished(result: String)

# ---------------------------------------------------------------
# Tham chiếu node
# ---------------------------------------------------------------
@export var units_root: Node2D
@export var spawn_points: Node2D
@export var ui: CanvasLayer

@export_group("Tự sinh spawn point")
## Bật = thiếu node Units / SpawnPoints / Team<i> / Marker thì tự tạo lúc vào trận.
## Node đã có sẵn trong scene luôn được giữ nguyên, chỉ bổ sung phần thiếu.
@export var auto_generate_spawn_points: bool = true
## Vị trí (local so với SpawnPoints) của unit đầu tiên thuộc Team0.
@export var layout_origin: Vector2 = Vector2(200, 300)
## Khoảng dịch giữa các đội: Team i bắt đầu tại layout_origin + team_offset * i.
@export var team_offset: Vector2 = Vector2(600, 0)
## Khoảng dịch giữa các unit trong cùng một đội.
@export var unit_offset: Vector2 = Vector2(0, 80)
@export_group("")

@onready var machine: BattleStateMachine = $BattleStateMachine
@onready var turn_queue: TurnQueue = $TurnQueue

# ---------------------------------------------------------------
# Dữ liệu vào: gán TRƯỚC khi add_child scene Battle
# teams[0] = đội người chơi điều khiển, các đội còn lại do AI
# ---------------------------------------------------------------
var teams: Array[Team] = []  # Array[Array[Player]]

# ---------------------------------------------------------------
# Trạng thái trận
# ---------------------------------------------------------------
var active_unit: Player
var round_number: int = 0
var is_finished: bool = false


func _ready() -> void:
	await owner.ready
	if teams.is_empty():
		push_warning("BattleManager: teams rỗng (chạy riêng scene để test?). Hãy gán dữ liệu mẫu.")
		return
	print(teams.size())
	for i in teams.size():
		print(teams[i].players.size())
		for player: Player in teams[i].players:
			print(player.avatar.Name)
			player.team_index = i
	turn_queue.round_started.connect(begin_new_round)
	machine.init(self)  # initial_state của machine = Setup


# ===============================================================
# SPAWN (State Setup gọi)
# ===============================================================
## Đảm bảo có Units / SpawnPoints / Team<i> / Marker2D đủ cho mọi unit.
## Chỉ tạo phần thiếu, không đụng tới node bạn đã đặt tay trong scene.
## Node tự sinh chỉ tồn tại lúc chạy (xem trong tab Remote của Scene dock).
func _ensure_spawn_points() -> void:
	if units_root == null:
		units_root = Node2D.new()
		units_root.name = "Units"
		get_parent().add_child(units_root)

	if spawn_points == null:
		spawn_points = Node2D.new()
		spawn_points.name = "SpawnPoints"
		get_parent().add_child(spawn_points)

	if not auto_generate_spawn_points:
		return

	for i in teams.size():
		var team_node := spawn_points.get_node_or_null("Team%d" % i) as Node2D
		if team_node == null:
			team_node = Node2D.new()
			team_node.name = "Team%d" % i
			spawn_points.add_child(team_node)

		# bổ sung marker còn thiếu, đánh số tiếp từ số marker đang có
		for j in range(team_node.get_child_count(), teams[i].players.size()):
			var marker := Marker2D.new()
			marker.name = "Spawn%d" % j
			marker.position = layout_origin + team_offset * i + unit_offset * j
			team_node.add_child(marker)


func get_spawn_points(team_index: int) -> Array[Node]:
	var root := spawn_points.get_node_or_null("Team%d" % team_index)
	if root == null:
		push_error("Thiếu SpawnPoints/Team%d" % team_index)
		return []
	return root.get_children()


## Đặt tất cả unit vào đúng điểm xuất phát của đội mình rồi thêm vào scene.
func spawn_all_units() -> void:
	_ensure_spawn_points()
	for i in teams.size():
		var points := get_spawn_points(i)
		for j in teams[i].players.size():
			var unit: Player = teams[i].players[j]
			unit.team_index = i
			if j < points.size():
				unit.global_position = points[j].global_position
			else:
				push_warning("Team%d thiếu spawn point cho unit thứ %d" % [i, j])
			if unit.get_parent() == null:
				units_root.add_child(unit)


# ===============================================================
# TRUY VẤN UNIT (State, AI, UI gọi nhiều nhất)
# ===============================================================
func is_player_controlled(unit: Player) -> bool:
	return unit.team_index == 0


func get_team_units(team_index: int) -> Array[Player]:
	var result: Array[Player] = []
	if team_index < 0 or team_index >= teams.size():
		return result
	for u: Player in teams[team_index].players:
		if is_instance_valid(u) and u.is_alive():
			result.append(u)
	return result


func get_all_units() -> Array[Player]:
	var result: Array[Player] = []
	for i in teams.size():
		result.append_array(get_team_units(i))
	return result


func get_allies_of(unit: Player) -> Array[Player]:
	return get_team_units(unit.team_index)


## Mặc định mọi đội khác đều là kẻ thù (free-for-all).
## Muốn có liên minh giữa các đội AI thì thay bằng bảng quan hệ.
func are_hostile(a: Player, b: Player) -> bool:
	return a.team_index != b.team_index


func get_enemies_of(unit: Player) -> Array[Player]:
	var result: Array[Player] = []
	for u in get_all_units():
		if are_hostile(unit, u):
			result.append(u)
	return result


func get_unit_at(pos: Vector2, radius: float = 24.0) -> Player:
	for u in get_all_units():
		if u.global_position.distance_to(pos) <= radius:
			return u
	return null


# --- Khoảng cách / tầm (game di chuyển tự do, không grid) ---
func distance_between(a: Player, b: Player) -> float:
	return a.global_position.distance_to(b.global_position)


func is_in_range(a: Player, b: Player, attack_range: float) -> bool:
	return distance_between(a, b) <= attack_range


func get_units_in_range(pos: Vector2, attack_range: float, pool: Array[Player] = []) -> Array[Player]:
	var source: Array[Player] = pool if not pool.is_empty() else get_all_units()
	var result: Array[Player] = []
	for u in source:
		if u.global_position.distance_to(pos) <= attack_range:
			result.append(u)
	return result


func get_nearest_enemy(unit: Player) -> Player:
	var best: Player = null
	var best_dist := INF
	for e in get_enemies_of(unit):
		var d := distance_between(unit, e)
		if d < best_dist:
			best_dist = d
			best = e
	return best


# ===============================================================
# ĐIỀU KIỆN THẮNG / THUA
# ===============================================================
func check_defeat() -> bool:
	return get_team_units(0).is_empty()


func check_victory() -> bool:
	if check_defeat():
		return false
	for i in range(1, teams.size()):
		if not get_team_units(i).is_empty():
			return false
	return true


# ===============================================================
# ĐIỀU PHỐI LƯỢT (mỏng: chỉ thao tác dùng chung giữa nhiều state)
# ===============================================================
func start_turn_of(unit: Player) -> void:
	active_unit = unit
	unit.begin_turn()  # reset điểm hành động, ngân sách di chuyển, tick status
	turn_changed.emit(unit)


func begin_new_round() -> void:
	round_number += 1
	round_started.emit(round_number)


## Gỡ unit chết khỏi dữ liệu trận. Việc queue_free() để Player làm
## sau khi chạy xong animation chết.
func remove_unit(unit: Player) -> void:
	if unit.team_index >= 0 and unit.team_index < teams.size():
		teams[unit.team_index].erase(unit)
	turn_queue.remove(unit)
	unit_died.emit(unit)


# ===============================================================
# KẾT THÚC TRẬN (state BattleEnd gọi)
# ===============================================================
func finish(result: String) -> void:
	if is_finished:
		return
	is_finished = true
	battle_finished.emit(result)
	# Scene gọi trận nhận signal, xử lý phần thưởng rồi queue_free() scene Battle.
