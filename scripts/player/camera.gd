extends Camera3D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				fov += 2
			elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
				fov -= 2
			
			fov = clamp(fov, 30, 80)
	
	if event is InputEventMouseMotion:
		get_parent().rotate_y(deg_to_rad(-event.relative.x * .1))
		
		rotate_x(deg_to_rad(event.relative.y * .1))
		
		if get_parent().spring_length == 10:
			rotation.x = clamp(rotation.x, deg_to_rad(-20), deg_to_rad(20))
		else:
			rotation.x = clamp(rotation.x, deg_to_rad(-59), deg_to_rad(59))
	
	if event.is_action_pressed("switch_perspective"):
		get_parent().spring_length = 10 if get_parent().spring_length == 0 else 0

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
