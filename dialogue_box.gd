extends CanvasLayer

@onready var name_label: Label = $Panel/NameLabel
@onready var text_label: Label = $Panel/TextLabel
@onready var player: CharacterBody2D = $"../Player"

var lines: Array[String] = []
var current_line: int = 0
var is_open: bool = false

func _ready() -> void:
	visible = false

func open_dialogue(speaker_name: String, dialogue_lines: Array[String]) -> void:
	name_label.text = speaker_name
	lines = dialogue_lines
	current_line = 0
	is_open = true
	visible = true
	text_label.text = lines[current_line]
	player.can_move = false

func _process(_delta: float) -> void:
	if not is_open:
		return

	if Input.is_action_just_pressed("ui_accept"):
		current_line += 1
		if current_line < lines.size():
			text_label.text = lines[current_line]
		else:
			close_dialogue()

func close_dialogue() -> void:
	is_open = false
	visible = false
	player.can_move = true