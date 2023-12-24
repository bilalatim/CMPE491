extends Node3D

var ball = preload("res://ball.tscn")
var object1
var object2
var isball1: bool = true
func _ready() -> void:
	object1 = ball.instantiate()
	object2 = ball.instantiate()
	add_child(object1)
	add_child(object2)

#func Instantiate() -> void:
#
	#var instance = ball.instantiate()
	#add_child(instance)
	#var random_direction: Vector3
	#if(global_transform.origin.x >=  0):
		#random_direction = Vector3(-1.0, randf_range(0, 0.3), randf_range(-0.3, 0.3))
	#else:
		#random_direction = Vector3(1.0, randf_range(0, 0.3), randf_range(-0.3, 0.3))
	#random_direction *= randi_range(50,100)
	#instance.apply_impulse(random_direction)

func Reuse() -> void:
	var random_direction: Vector3
	
	if(global_transform.origin.x >=  0):
		random_direction = Vector3(-1.0, randf_range(0, 0.3), randf_range(-0.3, 0.3))
	else:
		random_direction = Vector3(1.0, randf_range(0, 0.3), randf_range(-0.3, 0.3))
	random_direction *= randi_range(50,100)
	if(isball1):
		object1.set_process(false)
		object1.hide()
		object1.global_transform.origin = global_transform.origin
		object1.set_process(true)
		object1.apply_impulse(random_direction)
		isball1 = false
	else:
		object2.global_position = global_position
		object2.apply_impulse(random_direction)
		isball1 = true


var delay: float = 1.0
func _process(delta: float) -> void:
	# Belirli aralıklarla rastgele güç uygula
	delay -= delta
	if delay <= 0.0:
		Reuse()
		delay = randf_range(2, 4) # Gecikmeyi sıfırla
	
