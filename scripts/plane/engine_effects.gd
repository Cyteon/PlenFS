extends Node3D

@onready var plane = get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if plane.throttle_command > 0:
		$CPUParticles3D.emitting = true
	
	$CPUParticles3D.initial_velocity_max = 3 * plane.throttle_command
	$AudioStreamPlayer3D.volume_db = -10 + plane.throttle_command * 10
	


func _on_audio_stream_player_3d_finished() -> void:
	$AudioStreamPlayer3D.play()
