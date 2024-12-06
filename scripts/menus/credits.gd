extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	var label = RichTextLabel.new()
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.add_theme_font_size_override("normal_font_size", 32)
	
	label.text = "
	This project is licensed under the GNU AGPL v3
	Scroll past the AGPL license to see the Godot Copyright Information
	Developer: Cyteon
	
	########## Start Other Licenses ##########
	
	3D Model \"Cessna 172\" by KOG_THORNS, used under the CC BY 4.0 / Cropped from original.
	Available at: https://sketchfab.com/3d-models/cessna172-d1b15841c29c43d0862667300bad55a4
	Licensed under: CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/)
	
	########## End Other Licenses  ##########
	
	GNU GPL v3:
	
	"
	
	var file = FileAccess.open("res://LICENSE", FileAccess.READ)
	var content = file.get_as_text()
	
	label.text += content
	
	file = FileAccess.open("res://GODOT_COPYRIGHT.txt", FileAccess.READ)
	content = file.get_as_text()
	
	label.text += "\n\n" + content
	
	$ScrollContainer.add_child(label)
