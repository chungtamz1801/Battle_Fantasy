extends RefCounted

class_name FileUtil

static func read_data_from_file(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	
	if file == null:
		push_error("Cannot open file: "+path)
		
	var data = JSON.parse_string(file.get_as_text())
	
	if data == null:
		push_error("Invalid JSON: "+path)
		
	if not data is Dictionary:
		push_error("Data must be an array: %d" % typeof(data))
		
	return data
