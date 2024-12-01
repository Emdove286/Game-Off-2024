extends CanvasLayer
@export var player : Player
@onready var health: Label = $Health
@onready var keys: Label = $Keys

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("add_keys",  Callable(self, "add_keys"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health.text = str(player.health)
	
func add_keys(keyamount):
	keys.text = str(keyamount) + " out of 2 keys found"
