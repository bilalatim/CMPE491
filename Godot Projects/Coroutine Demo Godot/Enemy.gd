extends RigidBody2D


# Called when the node enters the scene tree for the first time.
@export var speed = 200
var direction = Vector2(0,0)

func _ready() -> void:
	ChangeMoveDirection()
	ChangeSpeed()
	request_confirmation()
	wait_button()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += speed * delta * direction
	
	
func ChangeSpeed():
	while (true):
		speed = 200
		await get_tree().create_timer(2).timeout
		speed = 50
		await get_tree().create_timer(18).timeout


func ChangeMoveDirection():
	while true:
		direction = Vector2.UP
		await get_tree().create_timer(2.1).timeout
		print(400/speed)
		direction = Vector2.RIGHT
		await get_tree().create_timer(900/speed).timeout
		print(900/speed)
		direction = Vector2.DOWN
		await get_tree().create_timer(400/speed).timeout
		direction = Vector2.LEFT
		await get_tree().create_timer(900/speed).timeout
		
func get_signal():
	return $Button.button_down

func wait_button():
	await get_signal()
	print("Button was pressed")
		
		
func wait_confirmation():
	print("Prompting user")
	await $Button.button_up # Waits for the button_up signal from Button node.
	print("User confirmed")
	return true
	
func request_confirmation():
	print("Will ask the user")
	var confirmed = await wait_confirmation()
	if confirmed:
		print("User confirmed")
	else:
		print("User cancelled")
		


	
