extends Node

@onready var steering_left = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Steering_MAT_0/Steering_Left"
@onready var steering_right = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Steering_MAT_0_001/Cessna_Interior_Steering_MAT_0_001_Steering_MAT_0"
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
	
	var knots = get_parent().linear_velocity.length() * 1.079914
	
	if knots <= 60:
		knots_indicator.rotation_degrees = Vector3(
			12.1, -5.2, 
			slope_0_60 * knots + intercept_0_60
		)
	else:
		# Second range: 60 knots and above
		knots_indicator.rotation_degrees = Vector3(
			12.1, -5.2,
			slope_60_plus * (knots - 60) + intercept_60_plus
		)
