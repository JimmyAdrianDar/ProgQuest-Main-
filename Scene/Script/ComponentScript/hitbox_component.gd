extends Area2D

@export var stat_component : NodePath

signal receive_damage(damage: int, knockback)

var statpath : Node


func _ready() -> void:
	statpath = get_node(stat_component)

func receive(receive_damaged: int, kb_modifier: float, damage_source_direction: Vector2):
	var damage_receive = receive_damaged
	var knockback_modifier = kb_modifier
	var knockback_direction = damage_source_direction.direction_to(self.global_position)
	damage_receive -= statpath.Defense #compute raw damage to defense
	var knockback_strength = damage_receive * knockback_modifier
	var knockback = knockback_direction * knockback_strength
	if !damage_receive == null:
		emit_signal("receive_damage", damage_receive, knockback)
