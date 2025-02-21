extends Control

var game_over_score
var score_label
var high_score_label
var save_path = "user://save_score.dat"

# Called when the node enters the scene tree for the first time.
func _ready():
	game_over_score = get_node("GameOverPanel/VBoxContainer/GameOverScoreText")
	score_label = get_node("ScoreLabel")
	high_score_label = get_node("GameOverPanel/VBoxContainer/HighScoreText")
	
	if ! FileAccess.file_exists(save_path):
		save_score(0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# When reset button is pressed, restart the scene
func _on_reset_button_pressed():
	get_tree().reload_current_scene()


func _on_game_over_panel_visibility_changed():
	var current_score = score_label.score
	game_over_score.text = "Score: %s" % current_score
	
	var high_score = load_score()

	if high_score < current_score:
		save_score(current_score)
		high_score = current_score
	
	high_score_label.text = "High Score: %s" % high_score

func save_score(score):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_16(score)
	file.close()

func load_score():
	var file = FileAccess.open(save_path, FileAccess.READ)
	var score = file.get_16()
	file.close()
	return score
	
