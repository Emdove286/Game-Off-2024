extends Node3D
var active = false
@export var HUD: CanvasLayer
# Called when the node enters the scene tree for the first time.

func _process(delta):
	if Input.is_action_just_pressed("interact") && active:
		HUD.showInfoText("Hello This is a Test Level",5)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Engineer":
		active = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Engineer":
		active = false
