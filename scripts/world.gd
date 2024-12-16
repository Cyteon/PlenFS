extends Node3D


func _ready() -> void:
	if Settings.show_perf_monitor:
		$CanvasLayer/Control/DebugMenu.visible = true
		RenderingServer.viewport_set_measure_render_time(get_tree().root.get_viewport_rid(), true)
		
		$CanvasLayer/Control/DebugMenu/CPU.text = OS.get_processor_name()
		$CanvasLayer/Control/DebugMenu/GPU.text = RenderingServer.get_video_adapter_name().trim_suffix("/PCIe/SSE2")
		$CanvasLayer/Control/DebugMenu/OS.text = "%s %s" % [
			OS.get_name(), 
			"64-bit" if OS.has_feature("64") else "32-bit"
		]
	
	match Settings.time:
		1:
			$WorldEnvironment/Sun.light_energy = 0.1
			$WorldEnvironment.environment.sky.sky_material.panorama = load("res://assets/world/NightSkyHDRI008_4K-TONEMAPPED.jpg")

func _process(delta: float) -> void:	
	if Input.is_action_pressed("pause"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$CanvasLayer/Control/PauseMenu.visible = true
		get_tree().paused = true

	if Settings.show_perf_monitor:
		var rid = get_tree().root.get_viewport_rid()
		var fps = Engine.get_frames_per_second()
		
		$CanvasLayer/Control/DebugMenu/FPS.text = "%s FPS" % fps
		
		if fps > 50 && fps < 70:
			$CanvasLayer/Control/DebugMenu/FPS.modulate = Color.YELLOW
		elif fps < 50:
			$CanvasLayer/Control/DebugMenu/FPS.modulate = Color.RED
		else:
			$CanvasLayer/Control/DebugMenu/FPS.modulate = Color.GREEN

		
		$CanvasLayer/Control/DebugMenu/FrameTime.text = "Frame Time: %sms" % snapped(Performance.get_monitor(Performance.TIME_PROCESS) * 1000, 0.01)
		
		$CanvasLayer/Control/DebugMenu/PhysicsTime.text = "Phys. Time: %sms" % snapped(Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS) * 1000, 0.01)
		
		$CanvasLayer/Control/DebugMenu/CPUTime.text = "CPU Time: %sms" % snapped(
			RenderingServer.viewport_get_measured_render_time_cpu(rid) + RenderingServer.get_frame_setup_time_cpu(), 
			0.01
		)
		
		$CanvasLayer/Control/DebugMenu/GPUTime.text = "GPU Time: %sms" % snapped(RenderingServer.viewport_get_measured_render_time_gpu(rid), 0.01)
