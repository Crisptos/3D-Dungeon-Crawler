# This resource is a container that encapsulates all player inventory data.

extends Resource

class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, button: int)

# Array of inventory SlotData
@export var slot_array: Array[SlotData]
# Inventory ID that is kept within an inventory manager Hash Map for easy look up
@export var id: int

# Called whenever a slot is clicked
func on_slot_clicked(index: int, button: int) -> void:
	inventory_interact.emit(self, index, button)

# Called from the interact event function during a pick up event
func grab_slot_data(index: int) -> SlotData:
	var slot_data = slot_array[index]
	if slot_data:
		slot_array[index] = null
		inventory_updated.emit(self)
		return slot_data
	else:
		return null

# Called from the interact event function during a drop event
func drop_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	var slot_data = slot_array[index]
	
	slot_array[index] = grabbed_slot_data
	inventory_updated.emit(self)
	if slot_data:
		return slot_data
	else:
		return null

func use_slot_data(index: int):
	var slot_data = slot_array[index]
	if slot_data:
		slot_data.use_item()
		if slot_data.get_total() == 0:
			slot_array[index] = null
		inventory_updated.emit(self)
	else:
		return

func get_id() -> int:
	return id
