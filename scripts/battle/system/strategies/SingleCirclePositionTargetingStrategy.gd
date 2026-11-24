extends TargetingStrategy

class_name SingleCirclePositionTargetingStrategy
var radius: float
var center: Vector2


func _init(p_radius:float, p_center:Vector2):
	target_result_mode = TargetResultMode.POSITION
	target_category = TargetCategory.POSITION
	
	radius = p_radius
	center = p_center
	
func create_action_request(actor: Player):
	if is_valid and actor.global_position.distance_squared_to(targeting_area.global_position) <= radius*radius:
		action_request = PositionActionRequest.new(targeting_area.global_position,actor)
		print(action_request)
		targeting_done.emit(action_request)
	
func update(mouse_position: Vector2):
	targeting_area.position = mouse_position

func draw_area(canvas: Node2D):
	init_targeting_area()
	canvas.add_child(targeting_area)
	canvas.draw_arc(
		center,
		radius,
		0.0,
		TAU,
		64,
		Color.CYAN,
		2.0
	)

func init_targeting_area():
	targeting_area = Area2D.new()
	targeting_area.collision_layer = 0
	targeting_area.collision_mask = 2
	targeting_area.monitoring = true
	targeting_area.monitorable = false
	
	var collision_shape = CollisionShape2D.new()

	var circle := CircleShape2D.new()
	circle.radius = 10

	collision_shape.shape = circle
	targeting_area.add_child(collision_shape)
	targeting_area.body_entered.connect(_on_area_entered)
	targeting_area.body_exited.connect(_on_area_exited)
