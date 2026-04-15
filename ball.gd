extends CharacterBody2D


@export var speed = 300.0
signal left_scored_on
signal right_scored_on


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		
		if collision.get_collider().name == "GoalLeft":
			left_scored_on.emit()
		elif collision.get_collider().name == "GoalRight":
			right_scored_on.emit()
		velocity = velocity.bounce(collision.get_normal())

func load(_position, _direction):
	position = _position
	rotation = _direction
	velocity = Vector2(speed, 0).rotated(rotation)
