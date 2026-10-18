extends Resource

#Delete
class_name Stat
var point: int
var scale: int

static func from_dict(data: Dictionary) -> Stat:
	var stat = Stat.new()
	return stat
