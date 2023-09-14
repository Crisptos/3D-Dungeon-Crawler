extends Control

@onready var party = $Party

func set_player_party(party_data: PartyData):
	party.set_player_party(party_data)
