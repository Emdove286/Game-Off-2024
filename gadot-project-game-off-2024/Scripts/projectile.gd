extends RayCast3D

@export var speed := 10.0

func _physics_process(delta: float) -> void:
	position += global_basis * Vector3.BACK * speed * delta
	target_position = Vector3.BACK * speed * delta
	force_raycast_update()
	var collider = get_collider()
	if is_colliding():
		global_position = get_collision_point()
		set_physics_process(false)
		queue_free()
		
func _cleanup() -> void:
	queue_free()
