extends VehicleBody3D

const MAX_STEER = 0.8
const ENGINE_POWER = 300

@onready var camera_pivot = $CameraPivot
@onready var camera = $CameraPivot/Camera3D
@onready var camera_back = $CameraPivot/Camera3D2

var look_at
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("jump"):
		brake = 100.0
	else:
		brake = 0.0
	steering = move_toward(steering, Input.get_axis("ui_right", "ui_left") * MAX_STEER, delta * 2.5)
	engine_force = Input.get_axis("ui_down", "ui_up") * ENGINE_POWER
	camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 20.0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
	look_at = look_at.lerp(linear_velocity + global_position, delta * 5.0)
	#camera.look_at(look_at)
	#camera_back.look_at(look_at)
	_check_camera_switch()
	
func _check_camera_switch():
	if linear_velocity.dot(transform.basis.z) > -3:
		camera.look_at(look_at)
		camera.current = true
		camera_back.current = false
	#else:
		#camera.current = false
		#camera_back.current = true
			
