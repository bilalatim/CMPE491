extends Camera3D


@export var target: NodePath

@onready var car = get_node(target)
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_transform.origin = Vector3(car.global_transform.origin.x, 130 ,car.global_transform.origin.z)
