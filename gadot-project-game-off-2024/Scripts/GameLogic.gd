extends Node
var keys = 0
var door_closed = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("keyfound",  Callable(self, "key_found"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if keys >= 2 && door_closed:
		SignalBus.emit_signal("door_open")
		print("A door has open")
		door_closed = false
	if keys >= 3:
		get_tree().change_scene_to_file("res://Scenes/Levels/winning.tscn")
	
func key_found():
	print("key count added")
	keys = keys + 1
