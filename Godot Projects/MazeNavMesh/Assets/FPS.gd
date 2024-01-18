extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var delay: float = 5.0
var totalFPS: float = 0.0
var countFPS: int = 0
var time: int = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var FPS = Engine.get_frames_per_second()
	text = "FPS: " + str(FPS)

	
	delay -= delta
	totalFPS += FPS
	countFPS +=1
	if delay <= 0.0:
		delay = 5.0
		time += 5
		print_debug(str(totalFPS/countFPS) + "  time: " + str(time) )
		totalFPS = 0
		countFPS = 0
