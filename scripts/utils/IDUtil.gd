extends RefCounted

class_name IDUtil

static func convert_string_into_id(string: String):
	return string.to_lower().replace(" ","_")
