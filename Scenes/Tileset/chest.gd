extends Node3D

signal inventory_clicked(inventory_data: InventoryData)

@export var inventory_data: InventoryData

func _on_mouse_detection_input_event(camera, event, position, normal, shape_idx):
	inventory_clicked.emit(inventory_data)
