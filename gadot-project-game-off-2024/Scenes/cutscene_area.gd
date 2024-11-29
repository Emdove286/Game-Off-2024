extends Area3D

@export var camera: Camera3D
@export var dialog_key = ""
var area_active = false

func _input(event):
		if area_active and event.is_action_pressed("interact"):
			SignalBus.emit_signal("display_dialog", dialog_key)
			#camera.make_current()
			#area_active = false


func _on_area_entered(area: Area3D) -> void:
	area_active = true


func _on_area_exited(area: Area3D) -> void:
	area_active = false
