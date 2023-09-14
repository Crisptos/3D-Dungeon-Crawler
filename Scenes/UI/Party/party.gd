# Script module for the Party UI node. Is managed by the PartyManager node and recieves PartyData that's sent to Character UI elements
extends Control

signal portrait_inventory_opened(index: int)

const character_portrait = preload("res://Scenes/UI/Party/character.tscn")
@onready var party_members = $MarginContainer/PartyMembers

# Called by the PartyManager
func set_player_party(party_data: PartyData):
	set_characters(party_data)

# Set a character portrait
func set_characters(party_data: PartyData):
	for member in party_data.party_members:
		var character = character_portrait.instantiate()
		party_members.add_child(character)
		character.portrait_clicked.connect(on_portrait_clicked)
		character.set_portrait(member)

# Called when one of its child's portraits is clicked
func on_portrait_clicked(index: int) -> void:
	print("Portrait %s was clicked" % index)
	portrait_inventory_opened.emit(index)

