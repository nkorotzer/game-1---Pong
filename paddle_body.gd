extends AnimatableBody2D


@export var speed = 400
var screen_size
var shape_size


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	var _rect_size = $CollisionShape2D/ColorRect.get_rect().size
	var _scale = $CollisionShape2D.get_transform().get_scale()
	shape_size = _rect_size * _scale

func _physics_process(delta: float) -> void:
	var dir = 0
	if Input.is_action_pressed("move_down"):
		dir = 1
	elif Input.is_action_pressed("move_up"):
		dir = -1
	
	var velocity = Vector2.ONE * dir * speed * delta
	velocity.x = 0
	move_and_collide(velocity)

func load(pos):
	position = pos
