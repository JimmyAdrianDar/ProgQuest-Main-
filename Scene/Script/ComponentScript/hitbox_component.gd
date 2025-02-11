extends Area2D

signal receive_damage(damage: int)

var damage_receive

func receive(damage):
	damage_receive = damage
	if !damage_receive == null:
		emit_signal("receive_damage", damage_receive)
