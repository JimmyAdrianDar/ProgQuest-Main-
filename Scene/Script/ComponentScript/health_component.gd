extends Node2D

@export var stat_component_path : NodePath

var max_health : int
var current_health : int
var defense_stat : int

signal died

func _ready() -> void:
	current_health = check_health()

#Check and returns the set value in the stat component
func check_health():
	var health_stat = get_node(stat_component_path)
	if health_stat:
		max_health = health_stat.Health
		return max_health

#It calculates the damage and subtracted the health and returns it
func reduce_health(damage: int):
	current_health -= damage
	current_health = max(0, current_health)
	if current_health <= 0:
		emit_signal("died")
	return current_health
