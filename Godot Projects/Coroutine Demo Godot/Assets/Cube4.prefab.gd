extends RigidBody3D

@export var destination: Vector3
@export var speed: float
@export var time: float
@export var use_speed: bool = false
@export var use_random_destination: bool = false

# Güç uygulama aralığı (saniye cinsinden)
var delay: float = 1.0


func _physics_process(delta: float) -> void:
	# Belirli aralıklarla rastgele güç uygula
	delay -= delta
	if delay <= 0.0:
		apply_random_force()
		delay = 1.0 # Gecikmeyi sıfırla

func apply_random_force() -> void:
	var random_direction = Vector3(randf_range(-50, 50), randf_range(0, 20), randf_range(-50, 50))
	apply_impulse(random_direction)

