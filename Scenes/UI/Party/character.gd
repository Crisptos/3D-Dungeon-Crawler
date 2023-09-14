extends Control

signal portrait_clicked(index: int)

@onready var portrait = $Portrait
@onready var health = $Bars/Health
@onready var stamina = $Bars/Stamina
@onready var mana = $Bars/Mana
@onready var left_hand = $"Left Hand"
@onready var right_hand = $"Right Hand"


func set_portrait(player_data: PlayerData):
	if player_data.portrait:
		portrait.texture = player_data.portrait
	health.max_value = player_data.health
	health.value = player_data.health
	stamina.max_value = player_data.health
	stamina.value = player_data.health
	mana.max_value = player_data.health
	mana.value = player_data.health

func _on_portrait_gui_input(event):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT:
		portrait_clicked.emit(get_index())
