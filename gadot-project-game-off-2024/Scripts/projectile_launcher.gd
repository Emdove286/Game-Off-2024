extends Node3D

const PROJECTILE = preload("res://Scenes/Character/projectile.tscn")

@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		if Input.is_action_pressed("shoot"):
			timer.start(0.25)
			var attack = PROJECTILE.instantiate()
			add_child(attack)
			attack.global_transform = global_transform
			
