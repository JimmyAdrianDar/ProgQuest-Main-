class_name hitbox extends Area2D

@export var stat_component : NodePath

signal receive_damage(damage: int)
signal damaged()

var statpath : Node


func _ready() -> void:
	statpath = get_node(stat_component)

func receive(receive_damaged: int):
	var damage_receive = receive_damaged
	if !damage_receive == null:
		emit_signal("receive_damage", damage_receive)
