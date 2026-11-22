extends RefCounted

class_name UIUtil

static func load_box_horizontal_UI(node: Node, data: Array[String], minimum_width: float):
	for child in node.get_children():
		child.queue_free()

	for index in data.size():
		var box = Button.new()
		box.text = data[index]
		box.name = "Box %d" % index
		box.size_flags_vertical = Control.SIZE_EXPAND_FILL
		box.custom_minimum_size.x = minimum_width
		node.add_child(box)
