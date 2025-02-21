extends Node2D

@export var pipe_scene: PackedScene
const SCROLL_SPEED : int = 4
var screen_size: Vector2i
var PIPE_DELAY : int = 100
var PIPE_RANGE : int = 150
var pipes : Array
var pipe_position : float
var game_over : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	game_over = false
	screen_size = get_window().size
	pipe_position = screen_size.y / 2
	$PipeTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (game_over == false):
		$ParallaxBackground.move_background(delta)
		for pipe in pipes:
				pipe.position.x -= SCROLL_SPEED
				if pipe.position.x < -100:
					pipe.queue_free()
					pipes.pop_front()

func _physics_process(delta):
	if game_over == false:
		$Player.flap(delta)
	else:
		pass
		# Player should be falling!

func _on_pipe_timer_timeout():
	generate_pipes()
	
func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = pipe_position + randi_range(-PIPE_RANGE, PIPE_RANGE)
	#pipe.z_index = -10
	if pipe.position.y > screen_size.y / 2:
		pipe.position.y = min(screen_size.y * 0.75, pipe.position.y)
	else:
		pipe.position.y = max(screen_size.y * 0.25, pipe.position.y)
		
	pipe_position = pipe.position.y
	var pipes_child = pipe.get_node("PipeArea")
	pipes_child.hit.connect(player_hit)
	
	var score_area_child = pipe.get_node("ScoreArea")
	score_area_child.scorePoints.connect($CanvasLayer/UserInterface/ScoreLabel._on_score_increase.bind())
	
	add_child(pipe)
	pipe.visible = true
	pipes.append(pipe)
	
func end_game():
	%GameOverPanel.show()
	$PipeTimer.stop()
	game_over = true
	
func player_hit():
	end_game()
	

