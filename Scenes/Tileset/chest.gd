extends Node3D

signal inventory_clicked(inventory_data: InventoryData)

@export var inventory_data: InventoryData

func _on_mouse_detection_input_event(_camera, _event, _position, _normal, _shape_idx):
	inventory_clicked.emit(inventory_data)
