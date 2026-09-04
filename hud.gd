extends CanvasLayer

@onready var inventory_label: Label = $Panel/InventoryLabel
@onready var player: CharacterBody2D = $"../Player"

func _ready() -> void:
    player.inventory_changed.connect(_on_inventory_changed)
    update_text(player.wood, player.stone)

func _on_inventory_changed(wood: int, stone: int) -> void:
    update_text(wood, stone)

func update_text(wood: int, stone: int) -> void:
    inventory_label.text = "Kayu: %d | Batu: %d" % [wood, stone]