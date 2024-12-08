extends Node3D

@onready var steering_left = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Steering_MAT_0/Steering_Left"
@onready var steering_right = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Steering_MAT_0_001/Steering_Right"
@onready var knots_indicator = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Knots_Indicator"
@onready var knots_indicator_2 = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Knots_Mach_Knots_indicator"
@onready var knots_indicator_3 = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Knots_Mach_Right_Knots_Indicator"
@onready var left_alt_indicator = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Left_Alt_Indicator"
@onready var left_alt_indicator_2 = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Alt_Indicator_2"
@onready var right_alt_indicator = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Right_Alt_indicator"
@onready var heading_indicator = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Cessna_Interior_Meter_01_MAT_0_Meter_01_MAT_0_098"
@onready var attitude_ball = $"../cessna_172/Cessna-172/Cessna_Interior/Cessna_Interior_Meter_01_MAT_0/Attitude_Ball"

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
	# Diffrent way of setting rot to verify altitude gauges working
	left_alt_indicator.rotation_degrees = Vector3(-82, get_parent().altitude / 1000 * 36, 0)
	$LeftAlt2Label.text = str(int(get_parent().altitude))
	left_alt_indicator_2.rotation_degrees.y = get_parent().altitude / 1000 * 36
	$RightAltLabel.text = str(int(get_parent().altitude))
	right_alt_indicator.rotation_degrees.y = get_parent().altitude / 1000 * 36
	
	# Knots indicator
	
	var knots = get_parent().linear_velocity.length() * 1.079914
	
	if knots <= 60:
		knots_indicator.rotation_degrees = Vector3(
			12.1, -5.2, 
			-0.1417 * knots + 156
		)
		
		knots_indicator_2.rotation_degrees.z = -0.1417 * knots - 48
		knots_indicator_3.rotation_degrees.z = -0.1417 * knots - 48
	else:
		knots_indicator.rotation_degrees = Vector3(
			12.1, -5.2,
			-1.175 * (knots - 60) + 147.5
		)
		
		knots_indicator_2.rotation_degrees.z = -1.275 * (knots - 60) - 56
		knots_indicator_3.rotation_degrees.z = -1.275 * (knots - 60) - 56
	
	$AudioStreamPlayer3D.volume_db = -20 + 20 * get_parent().throttle_command

	# Heading Indicator
	
	heading_indicator.rotation_degrees = Vector3(99.1, 16 - get_parent().rotation_degrees.y, 1.8)
	
	# Attitude
	
	attitude_ball.rotation_degrees.x = 3 - lerp(36, -33, (get_parent().rotation_degrees.x + 90) / 180)

func _on_audio_stream_player_3d_finished() -> void:
	$AudioStreamPlayer3D.play()
