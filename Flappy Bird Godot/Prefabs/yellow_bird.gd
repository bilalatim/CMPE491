extends CharacterBody2D


const JUMP_VELOCITY = -400.0
var screen_size = Vector2.ZERO

signal earn_point
signal lose_game

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play("yellowFly")

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Jump"):
		velocity.y = JUMP_VELOCITY
		
	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()
	



func _on_area_2d_area_entered(area: Area2D) -> void:
	emit_signal("earn_point")
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		emit_signal("lose_game")
	print(body.get_groups())
