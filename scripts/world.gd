extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var kmh = $AeroBody3D.linear_velocity.length() * 2
	
	$CanvasLayer/Control/VBoxContainer/kmh.text = "%s km/h" % int(kmh)
	$CanvasLayer/Control/VBoxContainer/knots.text = "%s kn" % int(kmh * 0.539957)
	$CanvasLayer/Control/VBoxContainer/throttle.text = "%s" % int($AeroBody3D.throttle_command * 100) + "%"
