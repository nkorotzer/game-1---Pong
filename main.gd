extends Node

@export var paddle_offset = 100
var screen_size
var left_score = 0
var right_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	screen_size = get_viewport().size
	
	$Player1StartingPos.position.x = paddle_offset
	$Player1StartingPos.position.y = screen_size.y / 2
	
	$Player2StartingPos.position.x = screen_size.x - paddle_offset
	$Player2StartingPos.position.y = screen_size.y / 2
	
	game_setup(true)
	
	$LeftScore.position.x = screen_size.x / 2 - 100
	$RightScore.position.x = screen_size.x / 2 + 100

func _on_ball_left_scored_on() -> void:
	game_setup(true)
	right_score += 1
	$RightScore.text = str(right_score)


func _on_ball_right_scored_on() -> void:
	game_setup(false)
	left_score += 1
	$LeftScore.text = str(left_score)

func game_setup(left: bool):
	$PlayerBody1.load($Player1StartingPos.position)
	$PlayerBody2.load($Player2StartingPos.position)
	var dir = randf_range(0.25, 0.35)
	if not left:
		dir = dir + 0.5
	$Ball.load(screen_size / 2, dir * PI)
