extends CharacterBody2D
class_name bird

func _physics_process(delta: float) -> void:
	velocity = Vector2(300,0)
	move_and_slide()
