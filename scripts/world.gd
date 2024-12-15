extends Node3D


func _ready() -> void:
	$CanvasLayer/Control/FPS.visible = Settings.show_fps
	
	match Settings.time:
		1:
			$WorldEnvironment/Sun.light_energy = 0.1
			$WorldEnvironment.environment.sky.sky_material.panorama = load("res://assets/world/NightSkyHDRI008_4K-TONEMAPPED.jpg")

func _process(delta: float) -> void:	
	if Input.is_action_pressed("pause"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$CanvasLayer/Control/PauseMenu.visible = true
		get_tree().paused = true

	$CanvasLayer/Control/FPS.text = "%s FPS" % Engine.get_frames_per_second()
