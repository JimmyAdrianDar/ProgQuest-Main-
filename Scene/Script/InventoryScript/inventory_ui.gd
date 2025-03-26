class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("res://Scene/Scene/InventorySlotScene/InventorySlot.tscn")

@export var data : InventoryData

@onready var inventory: Control = $"../../../.."

func _ready() -> void:
	inventory.shown.connect( update_inventory )
	inventory.hide_inventory.connect( clear_inventory )
	clear_inventory()
	pass

func clear_inventory() -> void:
	for c in get_children():
		c.queue_free()


func update_inventory() -> void:
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child( new_slot )
		new_slot.slot_data = s
	
	get_child( 0 ).grab_focus()
