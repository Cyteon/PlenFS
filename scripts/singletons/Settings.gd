extends Node

# graphics
var max_fps: int = 0
var show_fps: bool = false
var anti_aliasing: int = 0

# display
var fullscreen: bool = true

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
	
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen
		else DisplayServer.WINDOW_MODE_WINDOWED
	)

func save() -> void:
	var config = ConfigFile.new()
	
	config.set_value("graphics", "max_fps", max_fps)
	config.set_value("graphics", "show_fps", show_fps)
	config.set_value("graphics", "anti_aliasing", anti_aliasing)
	
	config.set_value("display", "fullscreen", fullscreen)
	
	config.save("user://settings.cfg")
	
	apply()

func load_() -> void:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	if err != OK:
		return
	
	max_fps = config.get_value("graphics", "max_fps", 0)
	show_fps = config.get_value("graphics", "show_fps", false)
	anti_aliasing = config.get_value("graphics", "anti_aliasing", 0)
	
	fullscreen = config.get_value("display", "fullscreen", true)
	
	apply()
