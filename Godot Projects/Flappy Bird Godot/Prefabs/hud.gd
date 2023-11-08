extends CanvasLayer


signal play_game
signal restart_game

var score = 0

func update_score():
	score += 1
	$Skor.text = str(score)

func _on_button_pressed() -> void:
	emit_signal("play_game")	
	$Message.hide()
	$Button.hide()
	
	
func lose_game():
	$Restart.show()
	$Message.show()
	
	
func ready_game():
	$Button.show()
	score = 0
	$Skor.text = str(score)


func _on_restart_pressed() -> void:
	emit_signal("restart_game")	
	$Message.hide()
	$Restart.hide()
	
