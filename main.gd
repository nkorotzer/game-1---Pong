extends Node

@export var paddle_offset = 100
var screen_size
var left_score = 0
var right_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	
	$Player1StartingPos.position.x = paddle_offset
	$Player1StartingPos.position.y = screen_size.y / 2
	
	$Player2StartingPos.position.x = screen_size.x - paddle_offset
	$Player2StartingPos.position.y = screen_size.y / 2
	
	game_setup(0.25)
	
	$LeftScore.position.x = screen_size.x / 2 - 100
	$RightScore.position.x = screen_size.x / 2 + 100

func _on_ball_left_scored_on() -> void:
	game_setup(0.25)
	right_score += 1
	$RightScore.text = str(right_score)


func _on_ball_right_scored_on() -> void:
	game_setup(0.75)
	left_score += 1
	$LeftScore.text = str(left_score)

func game_setup(dir):
	$PlayerBody1.load($Player1StartingPos.position)
	$PlayerBody2.load($Player2StartingPos.position)
	$Ball.load(screen_size / 2, dir * PI)
