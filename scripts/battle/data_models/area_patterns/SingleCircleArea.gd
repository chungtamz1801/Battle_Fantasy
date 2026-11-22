extends AreaPattern

class_name SingleCircleArea

var radius:float

func _init(p_center: Vector2, p_radius: float):
	is_updated_position = false
	radius = p_radius
	postion = p_center

func draw_preview(canvas: Node2D) -> void:
	canvas.draw_arc(
		Vector2.ZERO,
		radius,
		0.0,
		TAU,
		64,
		Color.CYAN,
		2.0
	)
