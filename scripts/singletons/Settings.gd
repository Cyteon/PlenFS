extends Node

# graphics
var max_fps: int = 0
var show_perf_monitor: bool = false
var anti_aliasing: int = 2
var taa: bool = true
var fxaa: bool = false
var vsync: bool = false

# display
var fullscreen: bool = true
var resolution: int = 1

# Not saved, aka in memory only
var time: int = 0

func _ready() -> void:
	load_()

func apply() -> void:
	Engine.max_fps = max_fps
	
	match anti_aliasing:
		0:
			get_viewport().msaa_3d = Viewport.MSAA_DISABLED
		1:
			get_viewport().msaa_3d = Viewport.MSAA_2X
		2:
			get_viewport().msaa_3d = Viewport.MSAA_4X
		3:
			get_viewport().msaa_3d = Viewport.MSAA_8X
	
	get_viewport().use_taa = taa
	get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_FXAA if fxaa else Viewport.SCREEN_SPACE_AA_DISABLED
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if vsync else DisplayServer.VSYNC_DISABLED)
	
	match resolution:
		0:
			get_window().set_size(Vector2(2560, 1440))
		1:
			get_window().set_size(Vector2(1920, 1080))
		2:
			get_window().set_size(Vector2(1600, 900))
		3:
			get_window().set_size(Vector2(1280, 720))
	
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen
		else DisplayServer.WINDOW_MODE_WINDOWED
	)

func save() -> void:
	var config = ConfigFile.new()
	
	config.set_value("graphics", "max_fps", max_fps)
	config.set_value("graphics", "show_perf_monitor", show_perf_monitor)
	config.set_value("graphics", "anti_aliasing", anti_aliasing)
	config.set_value("graphics", "taa", taa)
	config.set_value("graphics", "fxaa", fxaa)
	config.set_value("graphics", "vsync", vsync)
	
	config.set_value("display", "fullscreen", fullscreen)
	config.set_value("display", "resolution", resolution)
	
	config.save("user://settings.cfg")
	
	apply()

func load_() -> void:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	if err != OK:
		return
	
	max_fps = config.get_value("graphics", "max_fps", 0)
	show_perf_monitor = config.get_value("graphics", "show_perf_monitor", false)
	anti_aliasing = config.get_value("graphics", "anti_aliasing", 2)
	taa = config.get_value("graphics", "taa", true)
	fxaa = config.get_value("graphics", "fxaa", false)
	vsync = config.get_value("graphics", "vsync", false)
	
	fullscreen = config.get_value("display", "fullscreen", true)
	resolution = config.get_value("display", "resolution", 1)
	
	apply()
