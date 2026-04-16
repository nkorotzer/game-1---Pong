extends CharacterBody2D


@export var speed = 700.0
signal left_scored_on
signal right_scored_on


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		
		if collision.get_collider().name == "GoalLeft":
			left_scored_on.emit()
		elif collision.get_collider().name == "GoalRight":
			right_scored_on.emit()
		
		var normal = collision.get_normal()
		var dir = velocity.bounce(normal).normalized()
		velocity = dir * speed
		speed += 10

func load(_position, _direction):
	position = _position
	rotation = _direction
	speed = 700
	velocity = Vector2(speed, 0).rotated(rotation)
