extends Area2D

@export var speed = 400.0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Jump"):
		
		
