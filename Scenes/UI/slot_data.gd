# A data container for a single inventory slot

extends Resource

class_name SlotData

const MAX_STACK_SIZE: int = 99
@export var item_data: ItemData
@export_range (1, MAX_STACK_SIZE) var total: int = 1: set = set_total

# Setter for total
func set_total(n: int) -> void:
	total = n
	if total > 1 and not item_data.stackable:
		total = 1
		push_error("%s is non-stackable item contained multiple items. Reseting to 1" % item_data.name)

# Getter for total
func get_total() -> int:
	return total

# Decrement an item by 1 and use it
func use_item() -> void:
	if total > 0:
		total -= 1
