extends RigidBody3D

@onready var _move_timer : Timer = get_node("MoveTimer")

@export var move_delay = 3
var _object_pool : ObjectPool

func _ready():
	_object_pool = get_node("/root/ObjectPoolSingleton")
	_move_timer.connect("timeout", Callable(self, "_move_timeout"))
	_move_timer.start(move_delay)
	
func _move_timeout():
	_object_pool.return_node(self)

