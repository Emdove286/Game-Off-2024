extends CharacterBody3D
@export var payer_path :NodePath
var player = null
@export var speed = 10.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var jump_speed = 20.0
@onready var jump_timer: Timer = $JumpTimer
@onready var active_timer: Timer = $ActiveTimer

@onready var nav_agent = $NavigationAgent3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node(payer_path)
	jump_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += -gravity * delta
	if jump_timer.is_stopped():
		velocity = Vector3.ZERO
		nav_agent.set_target_position(player.global_transform.origin)
		var next_nav_point = nav_agent.get_next_path_position()
		velocity = (next_nav_point - global_transform.origin).normalized() * speed
		look_at(player.global_transform.origin)
		if is_on_floor():
			velocity.y =+ jump_speed
		if active_timer.is_stopped():
			jump_timer.start()
			velocity = Vector3.ZERO
	else:
		active_timer.start()
	
	move_and_slide()
