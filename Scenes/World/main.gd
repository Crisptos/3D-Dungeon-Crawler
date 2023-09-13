extends Node3D

signal close_while_selected()

@onready var player = $Player
@onready var chest = $Chest

@onready var inventory_manager = $UI/InventoryManager

func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_manager.set_player_inventory(player.inventory_data)

func toggle_inventory_interface():
	if inventory_manager.grabbed_slot.visible:
		close_while_selected.emit()
	inventory_manager.visible = !inventory_manager.visible
