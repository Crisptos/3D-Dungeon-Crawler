# Main script that's attached to the root node of world. Initiates calls to the inventory and party manager

extends Node3D

signal close_while_selected()

@onready var player = $Player
@onready var chest = $Chest

@onready var inventory_manager = $UI/InventoryManager
@onready var party_manager = $UI/PartyManager

func _ready() -> void:
	for inventory in player.party_inventories:
		inventory_manager.add_inventory(inventory)
	party_manager.set_player_party(player.party_data)

func toggle_inventory_interface(inventory_data: InventoryData):
	if inventory_manager.grabbed_slot.visible:
		close_while_selected.emit()
	inventory_manager.toggle_player_inventory()


func _on_chest_inventory_clicked(inventory_data):
	inventory_manager.toggle_chest_inventory() # Replace with function body.
