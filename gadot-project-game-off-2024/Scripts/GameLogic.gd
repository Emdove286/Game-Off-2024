extends Node
var keys = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("keyfound",  Callable(self, "key_found"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if keys >= 1:
		SignalBus.emit_signal("door_open")
		keys = 0
		print("A door has open")
	
func key_found():
	print("key count added")
	keys = keys + 1
