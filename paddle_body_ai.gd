extends AnimatableBody2D


@export var ai_speed = 500
var screen_size
var shape_size

var _ball
var _ball_last_x

var run_once = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	var _rect_size = $CollisionShape2D/ColorRect.get_rect().size
	var _scale = $CollisionShape2D.get_transform().get_scale()
	shape_size = _rect_size * _scale

func _physics_process(delta: float) -> void:
	get_ball()
	
	var dir = get_direction()
	var velocity = get_velocity(dir)
	
	var new_pos_y = position.y + velocity.y * delta
	var collision = move_and_collide(velocity * delta)
	
	if dir == 1 and new_pos_y > _ball.position.y and not collision:
		position.y = _ball.position.y
	elif dir == -1 and new_pos_y < _ball.position.y and not collision:
		position.y = _ball.position.y
	
	_ball_last_x = _ball.position.x

func load(pos):
	position = pos

func get_ball():
	var Ball = get_node("/root/Main/Ball")
	if Ball:
		_ball = Ball

func get_direction() -> int:
	var dir = 0
	
	if _ball.position.y > position.y:
#		dir == 1: going down
		dir = 1
	elif _ball.position.y < position.y:
#		dir == -1: going up
		dir = -1
	
	return dir
	
func get_velocity(dir) -> Vector2:
	var velocity = Vector2.ZERO
	
	if run_once:
		velocity = Vector2.ONE * dir * ai_speed
		velocity.x = 0
		run_once = 0
	elif _ball.position.x > _ball_last_x:
		velocity = Vector2.ONE * dir * ai_speed
		velocity.x = 0
	
	return velocity
