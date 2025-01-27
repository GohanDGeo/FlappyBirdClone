extends Area2D

signal scorePoints

func _on_body_entered(body):
	print("Score Area!")
	scorePoints.emit()
