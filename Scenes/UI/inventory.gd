# Script for the PlayerInventory node in the world scene. Recieves InventoryData and sends it to its children slots by order to populate them

extends PanelContainer

const inventory_slot = preload("res://Scenes/UI/inventory_slot.tscn")

var dragging: bool = false
@onready var Slots = $MarginContainer/Slots

# Called by the InventoryManager script when an inventory needs to be updated or initialized
func set_inventory(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_item_slots)
	populate_item_slots(inventory_data)

func update_inventory(inventory_data: InventoryData) -> void:
	populate_item_slots(inventory_data)

# Iterate through its children item slots and send to them the SlotData within the InventoryData it recieved
func populate_item_slots(inventory_data) -> void:
	for slot in Slots.get_children():
		slot.queue_free()
	
	for slot_data in inventory_data.slot_array:
		var slot = inventory_slot.instantiate()
		Slots.add_child(slot)
		
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		
		if slot_data:
			slot.set_slot_data(slot_data)

# Draggable window event
func _on_gui_input(event):
	if event is InputEventMouseButton:
		dragging = true
	else:
		dragging = false

func _physics_process(delta):
	if dragging:
		global_position = get_global_mouse_position() + Vector2(-5,-5)
