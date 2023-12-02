extends Node3D

@export var cubeNumber = 100000

var cube1Prefab = preload("res://Assets/Cube1.prefab.tscn")
var cube2Prefab = preload("res://Assets/Cube2.prefab.tscn")
var cube3Prefab = preload("res://Assets/Cube3.prefab.tscn")
var cube4Prefab = preload("res://Assets/Cube4.prefab.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func Instantiate() -> void:
	for i in range(cubeNumber):
		var instance = cube1Prefab.instantiate()
		add_child(instance)
