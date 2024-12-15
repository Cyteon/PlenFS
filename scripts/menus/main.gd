extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Version.text = "Version: " + ProjectSettings.get_setting("application/config/version")

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/tutorial.tscn")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/credits.tscn")


func _mouse_entered(path: String) -> void:
	var btn = get_node(path)
	var tween = get_tree().create_tween()
	
	tween.tween_property(btn, "modulate", Color.LIGHT_SKY_BLUE, .5)

func _mouse_exited(path: String) -> void:
	var btn = get_node(path)
	var tween = get_tree().create_tween()
	
	tween.tween_property(btn, "modulate", Color.WHITE, .5)

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/settings.tscn")
