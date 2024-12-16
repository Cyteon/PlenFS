extends Control

var loaded: bool = false

func _ready() -> void:
	$HBoxContainer/VBoxContainer/MaxFPS/SpinBox.value = Settings.max_fps
	$HBoxContainer/VBoxContainer/ShowPerfMonitor/CheckButton.button_pressed = Settings.show_perf_monitor
	$HBoxContainer/VBoxContainer/AntiAliasing/OptionButton.selected = Settings.anti_aliasing
	$HBoxContainer/VBoxContainer/FXAA/CheckButton.button_pressed = Settings.fxaa
	$HBoxContainer/VBoxContainer/TAA/CheckButton.button_pressed = Settings.taa
	$HBoxContainer/VBoxContainer/VSync/CheckButton.button_pressed = Settings.vsync
	
	$HBoxContainer/Display/Fullscreen/CheckButton.button_pressed = Settings.fullscreen
	$HBoxContainer/Display/Resolution/OptionButton.selected = Settings.resolution
	$HBoxContainer/Display/Resolution/OptionButton.disabled = Settings.fullscreen
	
	loaded = true

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main.tscn")

func _value_changed(val) -> void:
	if not loaded:
		return
	
	Settings.max_fps = $HBoxContainer/VBoxContainer/MaxFPS/SpinBox.value
	Settings.show_perf_monitor = $HBoxContainer/VBoxContainer/ShowPerfMonitor/CheckButton.button_pressed
	Settings.anti_aliasing = $HBoxContainer/VBoxContainer/AntiAliasing/OptionButton.selected
	Settings.fxaa = $HBoxContainer/VBoxContainer/FXAA/CheckButton.button_pressed
	Settings.taa = $HBoxContainer/VBoxContainer/TAA/CheckButton.button_pressed
	Settings.vsync = $HBoxContainer/VBoxContainer/VSync/CheckButton.button_pressed
	
	Settings.fullscreen = $HBoxContainer/Display/Fullscreen/CheckButton.button_pressed
	Settings.resolution = $HBoxContainer/Display/Resolution/OptionButton.selected
	$HBoxContainer/Display/Resolution/OptionButton.disabled = Settings.fullscreen
		
	Settings.save()
