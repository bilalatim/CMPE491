extends Node3D

const SPEED = 10.0

var camrot = 0.0


var map

var path = []
var show_path = true

@onready var robot  = get_node("Player")
@onready var camera = get_node("Main Camera/Camera")


func _ready():
	set_process_input(true)

	# use call deferred to make sure the entire SceneTree Nodes are setup
	# else yield on 'physics_frame' in a _ready() might get stuck
	call_deferred("setup_navserver")


func _physics_process(delta):
	var direction = Vector3()

	# We need to scale the movement speed by how much delta has passed,
	# otherwise the motion won't be smooth.
	var step_size = delta * SPEED

	if path.size() > 0:
		# Direction is the difference between where we are now
		# and where we want to go.
		var destination = path[0]
		direction = destination - robot.translation

		# If the next node is closer than we intend to 'step', then
		# take a smaller step. Otherwise we would go past it and
		# potentially go through a wall or over a cliff edge!
		if step_size > direction.length():
			step_size = direction.length()
			# We should also remove this node since we're about to reach it.
			path.remove(0)

		# Move the robot towards the path node, by how far we want to travel.
		# Note: For a KinematicBody, we would instead use move_and_slide
		# so collisions work properly.
		robot.translation += direction.normalized() * step_size

		# Lastly let's make sure we're looking in the direction we're traveling.
		# Clamp y to 0 so the robot only looks left and right, not up/down.
		direction.y = 0
		if direction:
			# Direction is relative, so apply it to the robot's location to
			# get a point we can actually look at.
			var look_at_point = robot.translation + direction.normalized()
			# Make the robot look at the point.
			robot.look_at(look_at_point, Vector3.UP)



func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 1000
		var target_point = NavigationServer3D.map_get_closest_point_to_segment(map, from, to)
		var optimize_path = true


	if event is InputEventMouseMotion:
		if event.button_mask & (MOUSE_BUTTON_MASK_MIDDLE + MOUSE_BUTTON_MASK_RIGHT):
			camrot += event.relative.x * 0.005
			get_node("CameraBase").set_rotation(Vector3(0, camrot, 0))
			print("Camera Rotation: ", camrot)

