extends Node2D

class_name TargetingPreview

var area_pattern: AreaPattern

func show_preview(pattern: AreaPattern) -> void:
	area_pattern = pattern
	global_position = pattern.postion
	visible = true
	queue_redraw()

func update_position(position: Vector2) -> void:
	if area_pattern.is_updated_position:
		global_position = position

func hide_preview() -> void:
	visible = false
	area_pattern = null

#func set_transform_data(
	#position: Vector2,
	#direction: Vector2
#) -> void:
	#global_position = position
	#rotation = direction.angle()

func _draw() -> void:
	if area_pattern == null:
		return

	area_pattern.draw_preview(self)
