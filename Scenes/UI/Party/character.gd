# Character script that recieves a PlayerData resource type and uses it to populate and update its children GUI nodes

extends Control

signal portrait_clicked(index: int)

@onready var portrait = $Portrait
@onready var health = $Bars/Health
@onready var stamina = $Bars/Stamina
@onready var mana = $Bars/Mana
@onready var left_hand = $"Left Hand"
@onready var right_hand = $"Right Hand"

# Called by the parent party GUI node script. Uses PartyData to populate UI elements
func set_portrait(player_data: PlayerData):
	if player_data.portrait:
		portrait.texture = player_data.portrait
	health.max_value = player_data.health
	health.value = player_data.health - 20
	stamina.max_value = player_data.health
	stamina.value = player_data.health
	mana.max_value = player_data.health
	mana.value = player_data.health

func _on_portrait_pressed():
	portrait_clicked.emit(get_index())

func heal(heal_value: int) -> void:
	health.value += heal_value
