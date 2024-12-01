extends Area3D

@export var ProjectileSpeed: int = 200
@export var ProjectileDamage: int = 20
@onready var Bullet: Area3D = $"."

var OriginPoint: Vector3
var CurrentPosition: Vector3
var Alive: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OriginPoint = Bullet.global_position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.z += position.z * ProjectileSpeed * delta
