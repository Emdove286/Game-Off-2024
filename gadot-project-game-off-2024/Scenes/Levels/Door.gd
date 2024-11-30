extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("door_open",  Callable(self, "open_door"))
	print(position)
	print(rotation)


func open_door():
	position = Vector3(1.58571,0.728795,-8.23852)
	rotation = Vector3(0, 2.391101, 0)
	print("THE DOOR TRIED TO OPEN")
