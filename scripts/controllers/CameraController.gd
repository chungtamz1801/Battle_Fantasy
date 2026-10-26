#extends Camera2D
#
#@export var edge_margin: float = 20.0
#@export var camera_speed: float = 600.0
#
#var was_scrolling := false
#
#func _process(delta: float) -> void:
	#var mouse_position := get_viewport().get_mouse_position()
	#var screen_size := get_viewport_rect().size
	##print(Engine.get_frames_per_second())
#
	#var direction := Vector2.ZERO
#
	#if mouse_position.x <= edge_margin:
		#direction.x -= 1.0
	#elif mouse_position.x >= screen_size.x - edge_margin:
		#direction.x += 1.0
#
	#if mouse_position.y <= edge_margin:
		#direction.y -= 1.0
	#elif mouse_position.y >= screen_size.y - edge_margin:
		#direction.y += 1.0
#
	#if direction != Vector2.ZERO:
		#direction = direction.normalized()
		#global_position += direction * camera_speed * delta
		#var movement := direction.normalized() * camera_speed * delta
		#print("Movement: ", movement)
		#print("Camera position: ", global_position)
		#print("Camera current: ", is_current())
		#
	#var is_scrolling := direction != Vector2.ZERO
	#if is_scrolling and not was_scrolling:
		#print("Edge scrolling started: ", Time.get_ticks_msec())
		#
	#if Input.is_action_pressed("ui_right"):
		#global_position.x += camera_speed * delta
#
	#was_scrolling = is_scrolling
extends Camera2D

@export var camera_speed: float = 600.0

func _process(delta: float) -> void:
	var direction := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
        "ui_down"
	)

	if direction != Vector2.ZERO:
		global_position += direction * camera_speed * delta
