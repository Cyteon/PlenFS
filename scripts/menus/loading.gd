extends Control

var status: int
var progress: Array[float]
var finished: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResourceLoader.load_threaded_request("res://scenes/world.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not finished:
		status = ResourceLoader.load_threaded_get_status("res://scenes/world.tscn", progress)
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			$ProgressBar.value = progress[0] * 100
		ResourceLoader.THREAD_LOAD_LOADED:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get("res://scenes/world.tscn"))
			finished = true
		ResourceLoader.THREAD_LOAD_FAILED:
			$Error.text = "An error has occured while loading the scene"
			print_stack()
			print("Error loading `res://scenes/world.tscn`")
			finished = true
