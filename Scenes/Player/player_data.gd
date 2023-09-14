# Encapsulates all the data of a single player character within a party

extends Resource

class_name PlayerData

@export var name: String = "Adventurer"
@export var race: String = "Adventurer"
@export var portrait: Texture
@export var health: int = 100
@export var stamina: int = 100
@export var mana: int = 100
@export var level: int = 1
@export var xp: int = 0
