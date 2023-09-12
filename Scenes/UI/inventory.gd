extends PanelContainer

const inventory_slot = preload("res://Scenes/UI/inventory_slot.tscn")

@onready var Slots = $MarginContainer/Slots

func set_inventory(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_item_slots)
	populate_item_slots(inventory_data)
	
	
func populate_item_slots(inventory_data) -> void:
	
	for slot in Slots.get_children():
		slot.queue_free()
	
	for slot_data in inventory_data.slot_array:
		var slot = inventory_slot.instantiate()
		Slots.add_child(slot)
		
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		
		if slot_data:
			slot.set_slot_data(slot_data)
