extends CharacterBody3D
class_name Player

@export var speed = 5.0
@export var acceleration = 4.0
@export var jump_speed = 8.0
@export var rotation_speed = 12.0
@export var mouse_sensitivity = 0.0015

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var jumping = false
var shoot = "2H_Ranged_Shooting"
var dodge = "Dodge_Backward"
var last_floor = true

@onready var spring_arm = $SpringArm3D
@onready var model = $Rig
@onready var anim_tree = $AnimationTree
@onready var anim_state = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	velocity.y += -gravity * delta
	get_move_input(delta)

	move_and_slide()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
		jumping = true
		anim_tree.set("parameters/conditions/grounded", false)
	anim_tree.set("parameters/conditions/jumping", jumping)
	if is_on_floor() and not last_floor:
		jumping = false
		anim_tree.set("parameters/conditions/grounded", true)
	last_floor = is_on_floor()
	if not is_on_floor() and not jumping:
		anim_state.travel("Jump_Idle")
		anim_tree.set("parameters/conditions/grounded", false)
	
	
	#if velocity.length() > 1.0:
		#model.rotation.y = lerp_angle(model.rotation.y, spring_arm.rotation.y, rotation_speed * delta)
	
func get_move_input(delta):
	var vy = velocity.y
	velocity.y = 0
	var input = Input.get_vector("left", "right", "forward", "back")
	var dir = Vector3(input.x, 0, input.y).rotated(Vector3.UP, spring_arm.rotation.y)
	velocity = lerp(velocity, dir * speed, acceleration * delta)
	var vl = velocity * model.transform.basis
	anim_tree.set("parameters/IWR/blend_position", Vector2(vl.x, -vl.z) / speed)
	if dir != Vector3.ZERO:
		dir = dir.normalized()
		model.basis = Basis.looking_at(lerp(velocity, dir * speed, acceleration * delta))
	velocity.y = vy
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		spring_arm.rotation.x -= event.relative.y * mouse_sensitivity
		spring_arm.rotation_degrees.x = clamp(spring_arm.rotation_degrees.x, -90.0, 30.0)
		spring_arm.rotation.y -= event.relative.x * mouse_sensitivity
	if event.is_action_pressed("shoot"):
		anim_state.travel(shoot)
	if event.is_action_pressed("dodge"):
		anim_state.travel(dodge)
	if event.is_action_pressed("interact"):
		anim_state.travel("Interact")