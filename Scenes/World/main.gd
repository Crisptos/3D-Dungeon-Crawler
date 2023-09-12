extends Node3D

@onready var player = $Player
@onready var inventory_manager = $UI/InventoryManager

func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_manager.set_player_inventory(player.inventory_data)

func toggle_inventory_interface():
	inventory_manager.visible = !inventory_manager.visible
