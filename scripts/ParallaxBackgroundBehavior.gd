extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func move_background(delta):
	scroll_base_offset -= Vector2(200,0) * delta 
