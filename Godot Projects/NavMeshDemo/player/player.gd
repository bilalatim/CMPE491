extends CharacterBody3D

@export var look_sensitivity:float = 0.5
@export var speed:float = 20
@export var jump_strength:float = 10
@export var is_gravity_enabled:bool = true
@export var gravity:float = -9.81
var vertical_velocity:Vector3 = Vector3.ZERO

@onready var head:Node3D = $Head

var is_mouse_captured:bool:
	get:return Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	
# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$MeshInstance3D.visible = false

func _physics_process(delta):
	var horizontal_direction = global_transform.basis.z * Input.get_axis("ui_up","ui_down") +  global_transform.basis.x * Input.get_axis("ui_left","ui_right")
	
	if is_gravity_enabled:
		if not is_on_floor(): vertical_velocity.y += gravity * delta
		elif Input.is_action_just_pressed("jump"): vertical_velocity.y = jump_strength
		else: vertical_velocity.y = 0
		velocity = horizontal_direction.normalized() * speed + vertical_velocity
	else: 
		var vertical_velocity = 0;
		if Input.is_key_pressed(KEY_Q) || Input.is_key_pressed(KEY_SPACE):
			vertical_velocity = 1;
		elif Input.is_key_pressed(KEY_E):
			vertical_velocity = -1;
		velocity = (horizontal_direction + Vector3.UP * vertical_velocity).normalized() * speed
	
	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if is_mouse_captured else Input.MOUSE_MODE_CAPTURED
	
	if is_mouse_captured:
		if event is InputEventMouseMotion:
			rotate_y(-deg_to_rad(event.relative.x))
			head.rotate_x(-deg_to_rad(event.relative.y))
			head.rotation.x = clamp(head.rotation.x,-90,90)
