extends Control

var grabbed_slot_data: SlotData
var index_holder: int
var id_holder: int

@onready var player_inventory = $PlayerInventory
@onready var grabbed_slot = $GrabbedSlot

var inventory_lookup = {}

func _physics_process(delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5,5)

func set_player_inventory(inventory_data: InventoryData) -> void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	inventory_lookup[inventory_data.get_id()] = inventory_data
	player_inventory.set_inventory(inventory_data)
	
func on_inventory_interact(inventory_data: InventoryData, index: int, button: int):
	match[grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			index_holder = index
			id_holder = inventory_data.get_id()
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			inventory_data.use_slot_data(index)
			
	update_grabbed_slot()

func update_grabbed_slot() -> void:
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()
	


func _on_world_close_while_selected():
	var returning_slot_data = grabbed_slot_data
	grabbed_slot_data = null
	inventory_lookup[id_holder].drop_slot_data(returning_slot_data, index_holder)
	id_holder = -1
	index_holder = -1
	update_grabbed_slot()
