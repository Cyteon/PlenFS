extends Camera3D

@onready var third_person_spring: SpringArm3D = $"../../SpringArmNode/SpringArm"

var third_person: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				fov += 2
			elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
				fov -= 2
			
			fov = clamp(fov, 30, 85)
	
	if event is InputEventMouseMotion:
		if third_person:
			third_person_spring.get_parent().rotate_y(deg_to_rad(-event.relative.x * .1))

			third_person_spring.rotate_x(deg_to_rad(-event.relative.y * .1))
			third_person_spring.rotation.x = clamp(third_person_spring.rotation.x, deg_to_rad(-59), deg_to_rad(59))
		else:
			get_parent().rotate_y(deg_to_rad(-event.relative.x * .1))
			
			rotate_x(deg_to_rad(event.relative.y * .1))
			rotation.x = clamp(rotation.x, deg_to_rad(-59), deg_to_rad(59))
	
	if event.is_action_pressed("switch_perspective"):
		if third_person:
			third_person = false
			
			current = true
			third_person_spring.get_node("Camera3D").current = false
		else:
			third_person = true
			
			current = false
			third_person_spring.get_node("Camera3D").current = true
