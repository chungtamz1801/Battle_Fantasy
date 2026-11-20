extends AreaPattern

class_name SingleCircleArea

var center: Vector2
var radius:float

func _init(p_center: Vector2, p_radius: float):
	radius = p_radius
	center = p_center

func draw_preview(canvas: Node2D) -> void:
	canvas.draw_arc(
		center,
		radius,
		0.0,
		TAU,
		64,
		Color.CYAN,
		2.0
	)
