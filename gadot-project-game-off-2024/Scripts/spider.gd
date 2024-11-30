extends CharacterBody3D
@export var payer_path :NodePath
var player = null
@export var speed = 10.0
@export var health = 10.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var jump_speed = 20.0
@onready var jump_timer: Timer = $JumpTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var active = false
var knockback = false
@onready var nav_agent = $NavigationAgent3D
@onready var knockbackTime: Timer = $knockback

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node(payer_path)
	jump_timer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += -gravity * delta
	if health <= 0:
		queue_free()
	if active:
		move_and_slide()



func _on_jump_timer_timeout() -> void:
	animation_player.play("JumpWindUp")
	while animation_player.is_playing():
		await get_tree().create_timer(0.01).timeout
	animation_player.play("Jump")
	while animation_player.is_playing():
		await get_tree().create_timer(0.01).timeout
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	animation_player.play("JumpAir")
	while(animation_player.is_playing()):
		if nav_agent.distance_to_target()> 1:
			if knockbackTime.is_stopped():
				velocity = (next_nav_point - global_transform.origin).normalized() * speed
			else:
				velocity = ((next_nav_point - global_transform.origin).normalized() * speed) * -1
			look_at(player.global_transform.origin)
			rotation.x = 0
			rotation.z = 0
		else:
			velocity = Vector3.ZERO
		await get_tree().create_timer(0.1).timeout
	velocity = Vector3.ZERO
	animation_player.play("JumpFall")
	jump_timer.start()
	
func hurtSpider(pain:int):
	health = health - pain




func _on_area_3d_area_entered(area: Area3D) -> void:
	hurtSpider(1)



func _on_activator_area_entered(area: Area3D) -> void:
	active = true
	print("SPIDER ACTIVATE")


func _on_activator_area_exited(area: Area3D) -> void:
	active = false
	print("SPIDER DE-ACTIVATE")


func _on_hit_box_area_entered(area: Area3D) -> void:
	knockback = true
	knockbackTime.start()


func _on_hit_box_area_exited(area: Area3D) -> void:
	pass # Replace with function body.
