extends CharacterBody2D

signal inventory_changed(wood: int, stone: int)

@export var speed: float = 200.0

var can_move: bool = true

var wood: int = 0
var stone: int = 0

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

func add_wood(amount: int = 1) -> void:
	wood += amount
	print("Kayu: ", wood)
	inventory_changed.emit(wood, stone)

func add_stone(amount: int = 1) -> void:
	stone += amount
	print("Batu: ", stone)
	inventory_changed.emit(wood, stone)