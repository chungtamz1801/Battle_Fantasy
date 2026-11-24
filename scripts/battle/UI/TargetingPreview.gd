extends Node2D

class_name TargetingPreview

var targeting_strategy: TargetingStrategy

func show_preview(r_targeting_strategy: TargetingStrategy) -> void:
	targeting_strategy = r_targeting_strategy
	visible = true
	queue_redraw()
	
func update_preview():
	targeting_strategy.update(get_local_mouse_position())
	
	#if targeting_strategy.is_redraw_required():
		#queue_redraw()

func hide_preview() -> void:
	visible = false
	targeting_strategy = null

#func set_transform_data(
	#position: Vector2,
	#direction: Vector2
#) -> void:
	#global_position = position
	#rotation = direction.angle()



func _draw() -> void:
	if targeting_strategy == null:
		return

	targeting_strategy.draw_area(self)
