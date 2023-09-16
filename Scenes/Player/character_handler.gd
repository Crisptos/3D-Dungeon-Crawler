extends Node

var chars: Array

func use_slot_data(slot_data: SlotData, id: int) -> void:
	slot_data.item_data.use(chars[id])
