#uncheck

extends BattleState
class_name SetUp
## State đầu tiên của trận (initial_state của BattleStateMachine).
##
## Chế độ đặt tay (manual_placement = true):
##   - Lần lượt từng unit của đội 0: unit hiện tại bám theo chuột
##   - Chuột trái  : đặt unit tại vị trí đó, chuyển sang unit tiếp theo
##   - Chuột phải  : undo, nhấc lại unit trước đó (unit đang cầm về điểm spawn)
##   - Đặt xong hết: nhấn Enter (ui_accept) để bắt đầu trận,
##                   vẫn có thể chuột phải để undo
## Chế độ tự động (manual_placement = false): đặt theo SpawnPoints rồi vào trận.
##
## Cần ở BattleManager: spawn_all_units(), get_all_units(), get_team_units(),
##                      turn_queue, units_root

@export var manual_placement: bool = true
## Vùng người chơi được phép đặt unit (ReferenceRect trong scene Battle).
## Để trống = đặt ở đâu cũng được.
@export var deploy_zone: ReferenceRect
## Khoảng cách tối thiểu giữa hai unit.
@export var min_spacing: float = 32.0
## Chừa chỗ cho intro/camera trước khi vào lượt đầu (giây).
@export var intro_delay: float = 0.5

const COLOR_OK := Color.WHITE
const COLOR_INVALID := Color(1.0, 0.4, 0.4)

var _arranging: bool = false
var _units: Array[Player] = []        # unit của đội 0, theo thứ tự đặt
var _spawn_pos: Dictionary = {}       # unit -> vị trí spawn ban đầu
var _index: int = 0                   # unit đang cầm; == _units.size() nghĩa là đã đặt hết


func enter(_data: Dictionary = {}) -> void:
	battle.spawn_all_units()

	_units = battle.get_team_units(0)
	_spawn_pos.clear()
	for unit in _units:
		_spawn_pos[unit] = unit.global_position

	if manual_placement and not _units.is_empty():
		_arranging = true
		_index = 0
		_pick_up(_index)
	else:
		_finish_setup()


func exit() -> void:
	_arranging = false
	for unit in _units:
		if is_instance_valid(unit):
			unit.modulate = COLOR_OK


func handle_input(event: InputEvent) -> void:
	if not _arranging:
		return

	if event is InputEventMouseMotion:
		if _is_holding():
			_follow_mouse()

	elif event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_place_current()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			_undo()

	elif event.is_action_pressed("ui_accept") and not _is_holding():
		_arranging = false
		_finish_setup()


# ---------------------------------------------------------------
# Đặt / undo
# ---------------------------------------------------------------
func _is_holding() -> bool:
	return _index < _units.size()


func _mouse_pos() -> Vector2:
	return battle.units_root.get_global_mouse_position()


func _pick_up(i: int) -> void:
	_index = i
	_follow_mouse()


func _follow_mouse() -> void:
	var unit := _units[_index]
	unit.global_position = _mouse_pos()
	unit.modulate = COLOR_OK if _is_valid_position(unit.global_position) else COLOR_INVALID


func _place_current() -> void:
	if not _is_holding():
		return
	var unit := _units[_index]
	if not _is_valid_position(unit.global_position):
		return  # vị trí sai: bỏ qua, người chơi chọn chỗ khác
	unit.modulate = COLOR_OK
	_index += 1
	if _is_holding():
		_pick_up(_index)  # unit tiếp theo bám theo chuột ngay


func _undo() -> void:
	if _is_holding():
		# unit đang cầm trả về điểm spawn
		var held := _units[_index]
		held.global_position = _spawn_pos[held]
		held.modulate = COLOR_OK
		if _index == 0:
			_pick_up(0)  # đang ở unit đầu tiên: không lùi thêm được
			return
	elif _units.is_empty():
		return
	_pick_up(_index - 1)  # nhấc lại unit đã đặt trước đó


func _is_valid_position(pos: Vector2) -> bool:
	if deploy_zone != null and not deploy_zone.get_global_rect().has_point(pos):
		return false
	# unit chưa đặt (kể cả unit đang cầm) không cản đường
	var unplaced := _units.slice(_index)
	for other in battle.get_all_units():
		if other in unplaced:
			continue
		if other.global_position.distance_to(pos) < min_spacing:
			return false
	return true


# ---------------------------------------------------------------
# Kết thúc setup
# ---------------------------------------------------------------
func _finish_setup() -> void:
	if intro_delay > 0.0:
		await battle.get_tree().create_timer(intro_delay).timeout
	battle.turn_queue.setup(battle.get_all_units())
	machine.change_state(&"TurnStart")
