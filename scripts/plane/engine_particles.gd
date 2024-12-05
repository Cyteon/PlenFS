extends CPUParticles3D

@onready var plane = get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if plane.throttle_command > 0:
		emitting = true
	
	initial_velocity_max = 3 * plane.throttle_command
