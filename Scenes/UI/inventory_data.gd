extends Resource

class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, button: int)

@export var slot_array: Array[SlotData]
@export var id: int

func on_slot_clicked(index: int, button: int) -> void:
	inventory_interact.emit(self, index, button)

func grab_slot_data(index: int) -> SlotData:
	var slot_data = slot_array[index]
	if slot_data:
		slot_array[index] = null
		inventory_updated.emit(self)
		return slot_data
	else:
		return null
		
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
