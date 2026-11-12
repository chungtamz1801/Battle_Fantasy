extends Resource

class_name Stat
var points: int
var scale: float

func get_result_stat() -> int:
	return roundi(points * scale)
