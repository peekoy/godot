extends Area2D

var player_in_range: bool = false
var player_ref

@onready var label: Label = $"../LabelBatu"

func _ready() -> void:
    label.text = ""

    body_entered.connect(_on_body_entered)
    body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
    if body.name == "Player":
        player_in_range = true
        label.text = "Batu"
        player_ref = body as CharacterBody2D

func _on_body_exited(body: Node2D) -> void:
    if body.name == "Player":
        player_in_range = false
        label.text = ""
        player_ref = null

func _process(_delta: float) -> void:
    if player_in_range and Input.is_action_just_pressed("interact"):
        if player_ref:
            player_ref.add_stone(1)