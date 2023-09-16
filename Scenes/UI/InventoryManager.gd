# Manages all active inventories in the scene and populates them with their respective InventoryData

extends Control

# A Temporary data holder for whatever is in the currently grabbed slot
var grabbed_slot_data: SlotData
# A temporary inventory index holder thats used during 'transactions' to remember where the item originated from
var index_holder: int
# A temporary inventory ID holder that used during 'transactions' to remember the ID of the inventory an item originated from
var id_holder: int

const character_inventory = preload("res://Scenes/UI/inventory.tscn")
@onready var grabbed_slot = $GrabbedSlot
@onready var party_inventories = $PartyInventories

# A hash map that stores and allows easy look up of all current inventories in the scene
var inventory_lookup = {}

# Called every physics frame. Checks if the grabbed slot is visible and if so, follow the mouse by an offset
func _physics_process(_delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5,5)

func add_inventory(inventory_data: InventoryData):
	inventory_lookup[inventory_data.get_id()] = inventory_data
	inventory_data.inventory_interact.connect(on_inventory_interact)
	var player_inventory = character_inventory.instantiate()
	party_inventories.add_child(player_inventory)
	player_inventory.hide()
	player_inventory.set_inventory(inventory_data)

# Called by the main script to initialize the player inventory
func set_player_inventory(index: int) -> void:
	var inventory_data = inventory_lookup[index]
	party_inventories.get_children()[index].update_inventory(inventory_data)

func toggle_player_inventory(index: int):
	party_inventories.get_children()[index].visible = !party_inventories.get_children()[index].visible

# Event handler function that's called whenever an interaction takes place
func on_inventory_interact(inventory_data: InventoryData, index: int, button: int):
	match[grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]: # Grabbed slot is empty but we left clicked, this is a picking up event
			index_holder = index
			id_holder = inventory_data.get_id()
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]: # Grabbed slot is not null and we left clicked, this is a dropping event
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]: # Grabbed slot is empty and we right clicked. This is a use item event
			inventory_data.use_slot_data(index)
			
	update_grabbed_slot()

# Update the grabbed slot upon completion of an inventory event
func update_grabbed_slot() -> void:
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()
	

# This event function is called whenever the UI is closed while an item was held
func _on_world_close_while_selected():
	var returning_slot_data = grabbed_slot_data
	grabbed_slot_data = null
	inventory_lookup[id_holder].drop_slot_data(returning_slot_data, index_holder)
	id_holder = -1
	index_holder = -1
	update_grabbed_slot()


func _on_party_portrait_inventory_opened(index):
	set_player_inventory(index)
	toggle_player_inventory(index)
