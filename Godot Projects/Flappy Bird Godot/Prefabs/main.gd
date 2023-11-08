extends Node

@export var yellow_pipe : PackedScene

func _ready() -> void:
	$GAME.get_tree().paused = true;
	$HUD.ready_game()
	randomize()
	
func _on_timer_timeout() -> void:
	var pipe_spawn_point = Vector2(550.0 ,randf() * 200 + 250.0)
	var new_yellow_pipe = yellow_pipe.instantiate()
	add_child(new_yellow_pipe)
	new_yellow_pipe.position = pipe_spawn_point
	
func start_game():	
	$GAME.get_tree().paused = false;
	
	
func lose_game():
	$GAME.get_tree().paused = true;
	$HUD.lose_game()


func restart_game() -> void:
	get_tree().reload_current_scene()
