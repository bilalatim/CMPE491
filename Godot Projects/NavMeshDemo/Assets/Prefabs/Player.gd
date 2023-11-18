extends CharacterBody3D

@onready var agent = $NavigationAgent3D
@onready var anim = $LowBody/GeneralSkeleton/AnimationPlayer

var SPEED = 4
var targ: Vector3

func _ready() -> void:
	targ = Vector3(10,0,10)
	updateTargetLocation(targ)

func _physics_process(delta: float) -> void:
		look_at(targ)
		rotation.x = 0
		rotation.z = 0
			
		
		
		if position.distance_to(targ) > 0.5:
			anim.play("Humanoid.library/Humanoid_Run.animation")
			var curLoc = global_transform.origin
			var nextLoc = agent.get_next_path_position()
			var newVel = (nextLoc - curLoc).normalized() * SPEED
			velocity = newVel
			move_and_slide()
		else:
			anim.stop()

func updateTargetLocation(target) -> void:
	agent.set_target_position(target)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		targ = raycast_from_mouse()
		updateTargetLocation(targ)

		
func raycast_from_mouse():
	var m_pos = get_viewport().get_mouse_position()
	var cam = get_tree().root.get_camera_3d()
	var ray_start = cam.project_ray_origin(m_pos)
	var ray_end = ray_start + cam.project_ray_normal(m_pos) * 2000
	var world3d : World3D = get_world_3d()
	var space_state = world3d.direct_space_state
	
	if space_state == null:
		return
	
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end, collision_mask)
	query.collide_with_areas = true
	
	return space_state.intersect_ray(query)["position"]

	
			

