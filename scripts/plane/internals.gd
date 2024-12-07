extends Node

@onready var steering_left = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Steering_MAT_0/Steering_Left"
@onready var steering_right = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Steering_MAT_0_001/Steering_Right"
@onready var knots_indicator = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Knots_Indicator"

var slope_0_60 = -0.1417
var intercept_0_60 = 156

var slope_60_plus = -1.175
var intercept_60_plus = 147.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var command = get_parent().control_command
	
	steering_left.rotation.z = lerp(steering_left.rotation.z, command.z * .5, .1)
	steering_right.rotation.z = lerp(steering_right.rotation.z, command.z * .5, .1)
	
	steering_left.position.z = lerp(steering_left.position.z, -.07 + .002605 * command.x, .1)
	steering_right.position.z = lerp(steering_right.position.z, -.071816 + .002605 * command.x, .1)
	
	$"../cessna_172/Cessna-172/Dynamic_Switch_005/Dynamic_Switch_005_New_Mat_0/Dynamic_Switch_005_New_Mat_0_New_Mat_0".position.z = 0.08 - 0.08 * get_parent().throttle_command
	
	var knots = get_parent().linear_velocity.length() * 1.079914
	
	if knots <= 60:
		knots_indicator.rotation_degrees = Vector3(
			12.1, -5.2, 
			slope_0_60 * knots + intercept_0_60
		)
	else:
		knots_indicator.rotation_degrees = Vector3(
			12.1, -5.2,
			slope_60_plus * (knots - 60) + intercept_60_plus
		)
