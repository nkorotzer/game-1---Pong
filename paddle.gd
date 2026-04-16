extends Area2D

@export var speed = 200
var screen_size
var shape_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	var _rect_size = $CollisionShape2D/ColorRect.get_rect().size
	var _scale = $CollisionShape2D.get_transform().get_scale()
	shape_size = _rect_size * _scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = 0
	
	if Input.is_action_pressed("move_down"):
		dir = 1
	elif Input.is_action_pressed("move_up"):
		dir = -1
	
	position.y += dir * speed * delta
	position.y = clamp(position.y, shape_size.y / 2, screen_size.y - shape_size.y / 2)

func load(pos):
	position = pos
