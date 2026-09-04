extends Area2D

var player_in_range: bool = false

@onready var prompt_label: Label = $"../Label"
@onready var dialogue_box: CanvasLayer = $"../DialogueBox"

var conversation: Array[String] = [
    "Welcome",
    "gas",
    "oke"
]

func _ready() -> void:
    body_entered.connect(_on_body_entered)
    body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
    if body.name == "Player":
        player_in_range = true
        prompt_label.text = "press e to talk"
    
func _on_body_exited(body: Node2D) -> void:
    if body.name == "Player":
        player_in_range = false
        prompt_label.text = "wasd or arrow key"

func _process(_delta: float) -> void:
    if player_in_range and Input.is_action_just_pressed("interact"):
        if not dialogue_box.is_open:
            dialogue_box.open_dialogue("NPC", conversation)