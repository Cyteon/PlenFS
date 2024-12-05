extends VehicleWheel3D

@export var MAX_STEER: float = 0.4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	steering = Input.get_axis("yaw_right", "yaw_left") * MAX_STEER
	brake = int(Input.is_action_pressed("brakes_up")) * 10
