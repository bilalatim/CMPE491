extends CharacterBody3D

@export var target: NodePath
@export var isRandom: bool
@onready var targetObject = get_node(target).global_position

@export var movement_speed: float = 4.0
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")

var targ: Vector3

func _ready() -> void:
	targ = targetObject
	set_random_movement_target()
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func set_random_movement_target():
	var randomArea = randi_range(0,3)
	var randomTargetVector
	if randomArea == 0:
		randomTargetVector = Vector3(randf_range(72,191), 0.5, randf_range(-125, -6))
	elif randomArea == 1:
		randomTargetVector = Vector3(randf_range(-60,60), 0.5, randf_range(-125, -6))
	elif randomArea == 2:
		randomTargetVector = Vector3(randf_range(-60,60), 0.5, randf_range(6, 125))
	else:
		randomTargetVector = Vector3(randf_range(72,191), 0.5, randf_range(6, 125))
	navigation_agent.set_target_position(randomTargetVector)

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		if isRandom:
			set_random_movement_target()
		return

	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3):
	velocity = safe_velocity
	move_and_slide()



	
