extends StaticBody3D

var agent = preload("res://Assets/Agent1.tscn")

func Instantiate() -> void:

	var instance = agent.instantiate()
	add_child(instance)
	
