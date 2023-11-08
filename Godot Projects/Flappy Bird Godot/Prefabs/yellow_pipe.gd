extends RigidBody2D

signal earn_point

@export var speed = -200

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

