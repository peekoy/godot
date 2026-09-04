extends CharacterBody3D

@export var speed: float = 8.0
@export var jump_velocity: float = 4.5
@export var mouse_sensitivity: float = 0.003
@export var rotation_speed: float = 12.0

@onready var visual: Node3D = $Visual
@onready var camera_pivot: Node3D = $CameraPivot
@onready var spring_arm: SpringArm3D = $CameraPivot/SpringArm3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
    spring_arm.add_excluded_object(get_rid())

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
        if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
            Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
        else:
            Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
    
    if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
        camera_pivot.rotate_y(-event.relative.x * mouse_sensitivity)
        spring_arm.rotate_x(-event.relative.y * mouse_sensitivity)
        spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(-60.0), deg_to_rad(30.0))

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y -= gravity * delta

    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = jump_velocity
    
    var input_dir := Vector2.ZERO
    if Input.is_key_pressed(KEY_A):
        input_dir.x -= 1
    if Input.is_key_pressed(KEY_D):
        input_dir.x += 1
    if Input.is_key_pressed(KEY_W):
        input_dir.y -= 1
    if Input.is_key_pressed(KEY_S):
        input_dir.y += 1
    
    input_dir = input_dir.normalized()

    var cam_basis := camera_pivot.global_transform.basis
    var forward := -cam_basis.z
    var right := cam_basis.x

    forward.y = 0.0
    right.y = 0.0

    forward = forward.normalized()
    right = right.normalized()

    var direction := (right * input_dir.x - forward * input_dir.y).normalized()

    if direction != Vector3.ZERO:
        velocity.x = direction.x * speed
        velocity.z = direction.z * speed

        var target_angle := atan2(-direction.x, -direction.z)
        visual.rotation.y = lerp_angle(visual.rotation.y, target_angle, delta * rotation_speed)
    else:
        velocity.x = move_toward(velocity.x, 0, speed)
        velocity.z = move_toward(velocity.z, 0, speed)

    move_and_slide()