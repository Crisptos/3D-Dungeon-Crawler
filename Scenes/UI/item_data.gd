#The item data resource is a container for everything related to single items

extends Resource

class_name ItemData

@export var name: String = ""
@export_multiline var desc: String = ""
@export var stackable: bool = false
@export var texture: Texture
