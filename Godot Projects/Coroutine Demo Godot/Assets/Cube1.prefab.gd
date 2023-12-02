extends Node3D

@export var target_position: Vector3

# Hareket süresi
var move_duration: float = 2.0

# İç zamanlayıcı
var elapsed_time: float = 0.0

# Başlangıç pozisyonu
var start_position: Vector3

func _ready():
	find_random_destination()
	
func find_random_destination():
	start_position = global_transform.origin
	target_position = Vector3(randf_range(-48, 48), randf_range(1, 30), randf_range(-48, 48))

func _process(delta):
	# Zamanlayıcıyı güncelle
	elapsed_time += delta

	var t = elapsed_time / move_duration
	t = min(t, 1.0) # 't' değerini 0 ile 1 arasında sınırla

	# Lerp fonksiyonu ile yeni pozisyonu hesapla
	var new_position = start_position.lerp(target_position, t)
	global_transform.origin = new_position

	if t >= 1.0:
		find_random_destination()
		elapsed_time = 0
