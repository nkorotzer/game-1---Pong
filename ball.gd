extends CharacterBody2D

var speed
@export var starting_speed = 700.0
signal left_scored_on
signal right_scored_on

func _ready() -> void:
	starting_speed = speed

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		
		if collision.get_collider().name == "GoalLeft":
			left_scored_on.emit()
		elif collision.get_collider().name == "GoalRight":
			right_scored_on.emit()
		
		if collision.get_collider().name == "PlayerBody1":
			var paddle_velocity = collision.get_collider_velocity()
			var normal = collision.get_normal()
			var ball_velocity_after_bounce = velocity.bounce(normal)
			var new_dir = (paddle_velocity + ball_velocity_after_bounce).normalized()
			velocity = new_dir * speed
		else:
			var normal = collision.get_normal()
			var dir = velocity.bounce(normal).normalized()
			velocity = dir * speed
		speed += 10

func load(_position, _direction):
	position = _position
	rotation = _direction
	speed = starting_speed
	velocity = Vector2(speed, 0).rotated(rotation)
