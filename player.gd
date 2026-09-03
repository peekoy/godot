extends CharacterBody2D

@export var speed: float = 200.0

var can_move: bool = true

func _physics_process(_delta: float) -> void:
	var direction := Vector2.ZERO

	if not can_move:
		return

	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_key_pressed(KEY_D):
		direction.x += 1
	if Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_key_pressed(KEY_S):
		direction.y += 1

	velocity = direction.normalized() * speed
	move_and_slide()