extends Area2D

@export var stat_component_path : NodePath

var damage_value: int
var knockback_modifier: float
var knockback_direction
var parent_node: Node = null
var enemy_in_range: bool = false
var attack_body : Node
var stat_path: Node

var is_on_cooldown: bool = false

func _ready() -> void:
	parent_node = self.get_parent()
	stat_path = get_node(stat_component_path)

func get_parent_value(damage: int, kb_modifier: float, damage_source_direction: Vector2):
	damage_value = damage
	knockback_modifier = kb_modifier
	knockback_direction = damage_source_direction

func _on_body_entered(body: Node2D) -> void:
	if body != parent_node:
		enemy_in_range = true
		attack_body = body

func define_body():
	var define_attack_body = attack_body
	return define_attack_body

func _process(delta: float) -> void:
	if attack_body and not is_on_cooldown:
		if attack_body.has_node("HitboxComponent"):
			var hitbox = attack_body.get_node("HitboxComponent")
			if hitbox.has_method("receive"):
				hitbox.receive(damage_value, knockback_modifier, knockback_direction)
				start_cooldown(stat_path.AttackCooldown)

func _on_body_exited(body: Node2D) -> void:
	if body != parent_node:
		enemy_in_range = false
		attack_body = null

func start_cooldown(cooldown_time: float) -> void:
	is_on_cooldown = true
	get_tree().create_timer(cooldown_time).timeout.connect(self._on_cooldown_complete)

# Callback when the cooldown ends
func _on_cooldown_complete() -> void:
	is_on_cooldown = false
