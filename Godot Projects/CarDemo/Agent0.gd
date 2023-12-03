extends CharacterBody3D

@export var target: NodePath
@onready var targetObject = get_node(target).global_position
@onready var agent = $NavigationAgent3D


var SPEED = 4.0
var targ: Vector3

func _ready() -> void:
	targ = targetObject
	updateTargetLocation(targ)

func _physics_process(delta: float) -> void:
		look_at(targ)
		rotation.x = 0
		rotation.z = 0
			

		var curLoc = global_transform.origin
		var nextLoc = agent.get_next_path_position()
		var newVel = (nextLoc - curLoc).normalized() * SPEED
		velocity = velocity.move_toward(newVel, .25)
		move_and_slide()

func updateTargetLocation(target) -> void:
	agent.set_target_position(target)



func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, .25)
	move_and_slide()
	
