extends CanvasLayer
@export var player : Player
@onready var health: Label = $Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health.text = str(player.health)
