extends Node3D

@onready var steering_left = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Steering_MAT_0/Steering_Left"
@onready var steering_right = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Steering_MAT_0_001/Steering_Right"
@onready var knots_indicator = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Knots_Indicator"
@onready var knots_indicator_2 = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Knots_Mach_Knots_indicator"
@onready var left_alt_indicator = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Left_Alt_Indicator"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var command = get_parent().control_command
	
	# Steering Wheels
	
	steering_left.rotation.z = lerp(steering_left.rotation.z, command.z * .5, .1)
	steering_right.rotation.z = lerp(steering_right.rotation.z, command.z * .5, .1)
	
	steering_left.position.z = lerp(steering_left.position.z, -.07 + .002605 * command.x, .1)
	steering_right.position.z = lerp(steering_right.position.z, -.071816 + .002605 * command.x, .1)
	
	# Throttle
	
	$"../cessna_172/Cessna-172/Dynamic_Switch_005/Dynamic_Switch_005_New_Mat_0/Dynamic_Switch_005_New_Mat_0_New_Mat_0".position.z = 0.08 - 0.08 * get_parent().throttle_command
	
	# Altitude indicators
	
	$LeftAltLabel.text = str(int(get_parent().altitude))
	left_alt_indicator.rotation_degrees = Vector3(-82, get_parent().altitude / 1000 * 36, 0)
	
	# Knots indicator
	
	var knots = get_parent().linear_velocity.length() * 1.079914
	
	if knots <= 60:
		knots_indicator.rotation_degrees = Vector3(
			12.1, -5.2, 
			-0.1417 * knots + 156
		)
		
		knots_indicator_2.rotation_degrees.z = -0.1417 * knots - 48
	else:
		knots_indicator.rotation_degrees = Vector3(
			12.1, -5.2,
			-1.175 * (knots - 60) + 147.5
		)
		
		knots_indicator_2.rotation_degrees.z = -1.275 * (knots - 60) - 56
