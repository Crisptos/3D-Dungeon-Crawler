extends PanelContainer

signal slot_clicked(index: int, button: int)

@onready var item_texture = $MarginContainer/ItemTexture
@onready var quantity_label = $QuantityLabel

func set_slot_data(slot_data: SlotData) -> void:
	var item_data : ItemData = slot_data.item_data
	item_texture.texture = item_data.texture
	tooltip_text = "%s\n%s" % [item_data.name, item_data.desc]

	if slot_data.total > 1:
		quantity_label.text = "x%s" % slot_data.total
		quantity_label.show()
	else:
		quantity_label.hide()
		


func _on_gui_input(event) -> void:
	if event is InputEventMouseButton \
		and (event.button_index == MOUSE_BUTTON_RIGHT \
		or event.button_index == MOUSE_BUTTON_LEFT) \
		and event.is_pressed():
		
		slot_clicked.emit(get_index(), event.button_index)
