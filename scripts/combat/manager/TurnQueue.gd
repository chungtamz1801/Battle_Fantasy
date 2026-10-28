#uncheck

class_name TurnQueue
extends Node
## Hàng đợi lượt theo vòng (round).
## Mỗi vòng: mọi unit còn sống được xếp theo speed giảm dần, xen kẽ giữa các đội.
## Hết vòng thì dựng lại hàng đợi (speed có thể đã thay đổi) và sang vòng mới.
##
## API:
##   setup(units)            dựng vòng đầu tiên (Setup state gọi)
##   next_unit() -> Player   lấy unit tiếp theo, null nếu không còn ai sống
##   remove(unit)            gỡ unit chết (BattleManager.remove_unit gọi)
##   reorder()               sắp xếp lại phần còn lại của vòng (khi speed đổi giữa chừng)
##   get_upcoming(count)     xem trước thứ tự lượt cho UI

signal round_started

var _all: Array[Player] = []     # mọi unit tham gia trận
var _order: Array[Player] = []   # thứ tự của vòng hiện tại
var _cursor: int = 0             # vị trí unit kế tiếp trong _order


func setup(units: Array[Player]) -> void:
	_all = units.duplicate()
	_order.clear()
	_cursor = 0
	_start_new_round()


func next_unit() -> Player:
	while true:
		if _cursor >= _order.size():
			_start_new_round()
			if _order.is_empty():
				return null  # không còn ai sống
		var unit: Player = _order[_cursor]
		_cursor += 1
		if is_instance_valid(unit) and unit.is_alive():
			return unit
	return null


func remove(unit: Player) -> void:
	_all.erase(unit)
	var idx := _order.find(unit)
	if idx == -1:
		return
	_order.remove_at(idx)
	if idx < _cursor:
		_cursor -= 1  # giữ con trỏ đúng chỗ khi gỡ unit đã đi qua


## Sắp xếp lại các unit CHƯA đi trong vòng này (ví dụ sau khi dính slow/haste).
func reorder() -> void:
	var remaining: Array[Player] = []
	for i in range(_cursor, _order.size()):
		remaining.append(_order[i])
	remaining.sort_custom(_compare)
	_order = _order.slice(0, _cursor)
	_order.append_array(remaining)


## Danh sách `count` lượt sắp tới (gồm cả vòng sau) để UI hiển thị thanh thứ tự.
func get_upcoming(count: int) -> Array[Player]:
	var result: Array[Player] = []
	for i in range(_cursor, _order.size()):
		if _is_alive(_order[i]):
			result.append(_order[i])
	var next_round := _build_round()
	while result.size() < count and not next_round.is_empty():
		result.append_array(next_round)
	return result.slice(0, count)


# ---------------------------------------------------------------
func _start_new_round() -> void:
	_order = _build_round()
	_cursor = 0
	if not _order.is_empty():
		round_started.emit()


func _build_round() -> Array[Player]:
	var alive: Array[Player] = []
	for u in _all:
		if _is_alive(u):
			alive.append(u)
	alive.sort_custom(_compare)
	return alive


func _is_alive(u: Player) -> bool:
	return is_instance_valid(u) and u.is_alive()


## Speed cao đi trước. Bằng nhau: đội nhỏ index đi trước (đội người chơi ưu tiên),
## rồi theo instance id để thứ tự luôn ổn định.
func _compare(a: Player, b: Player) -> bool:
	if a.initiative != b.initiative:
		return a.initiative > b.initiative
	if a.team_index != b.team_index:
		return a.team_index < b.team_index
	return a.get_instance_id() < b.get_instance_id()
