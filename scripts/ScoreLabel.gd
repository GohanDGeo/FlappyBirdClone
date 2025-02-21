extends Label

@export var score = 0

func _on_score_increase():
	score += 10
	text = "Score: %s" % score
