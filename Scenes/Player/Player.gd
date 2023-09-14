extends Node3D

@export var inventory_data: InventoryData
@export var party_data: PartyData

signal toggle_inventory()

@onready var front : = $Forwards_Collision
@onready var back : = $Backwards_Collision
@onready var left : = $Left_Collision
@onready var right : = $Right_Collision


var tween

func _physics_process(_delta):
	if tween is Tween:
		if tween.is_running():
			return
	if Input.is_key_pressed(KEY_Z):
		print(position)
	if Input.is_action_pressed("forward") and not front.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(-transform.basis.z), 0.5)
	if Input.is_action_pressed("backwards") and not back.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(transform.basis.z), 0.5)
	if Input.is_action_pressed("strafe_left") and not left.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(-transform.basis.x), 0.5)
	if Input.is_action_pressed("strafe_right") and not right.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(transform.basis.x), 0.5)
	if Input.is_action_pressed("turn_left"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2), 0.5)
	if Input.is_action_pressed("turn_right"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), 0.5)

func _unhandled_input(_event):
	if Input.is_action_pressed("toggle_inv"):
		toggle_inventory.emit()


