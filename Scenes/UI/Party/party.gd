extends Control

const character_portrait = preload("res://Scenes/UI/Party/character.tscn")
@onready var party_members = $MarginContainer/PartyMembers

func set_player_party(party_data: PartyData):
	set_characters(party_data)

func set_characters(party_data: PartyData):
	for member in party_data.party_members:
		var character = character_portrait.instantiate()
		party_members.add_child(character)
		character.portrait_clicked.connect(on_portrait_clicked)
		character.set_portrait(member)

func on_portrait_clicked(index: int) -> void:
	print("Portrait %s was clicked" % index)

