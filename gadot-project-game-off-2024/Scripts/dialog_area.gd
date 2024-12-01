extends Area3D


@export var dialog_key = ""
var area_active = false
@export var has_key = false

func _input(event):
		if area_active and event.is_action_pressed("interact"):
			if has_key:
				SignalBus.emit_signal("keyfound")
				print("keyfound")
				has_key = false
			SignalBus.emit_signal("display_dialog", dialog_key)
			



func _on_area_entered(area: Area3D) -> void:
	area_active = true


func _on_area_exited(area: Area3D) -> void:
	area_active = false
