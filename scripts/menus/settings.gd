extends Control

var loaded: bool = false

func _ready() -> void:
	$HBoxContainer/VBoxContainer/MaxFPS/SpinBox.value = Settings.max_fps
	$HBoxContainer/VBoxContainer/ShowFPS/CheckButton.button_pressed = Settings.show_fps
	$HBoxContainer/VBoxContainer/AntiAliasing/OptionButton.selected = Settings.anti_aliasing
	$HBoxContainer/Display/Fullscreen/CheckButton.button_pressed = Settings.fullscreen
	
	loaded = true

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main.tscn")

func _value_changed(val) -> void:
	if not loaded:
		return
	
	Settings.max_fps = $HBoxContainer/VBoxContainer/MaxFPS/SpinBox.value
	Settings.show_fps = $HBoxContainer/VBoxContainer/ShowFPS/CheckButton.button_pressed
	Settings.anti_aliasing = $HBoxContainer/VBoxContainer/AntiAliasing/OptionButton.selected
	
	Settings.fullscreen = $HBoxContainer/Display/Fullscreen/CheckButton.button_pressed
		
	Settings.save()
