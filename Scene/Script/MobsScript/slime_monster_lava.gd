extends CharacterBody2D

@onready var healthbar = $Healthbar
@onready var health_component = $HealthComponent
@onready var stat_component = $StatComponent
@onready var attack_component = $AttackComponent

var target_position
var is_on_cooldown: bool = false
var cooldown_timer: Node2D

var target_body: Node = null

func _ready() -> void:
	healthbar.init_health(health_component.check_health())

func _process(delta: float) -> void:
	handle_attack()

func _physics_process(delta: float) -> void:
	if target_body != null:
		if position.distance_to(target_body.position) > 10:
			var direction = (target_body.global_position - global_position).normalized()
			global_position += direction * stat_component.Speed * delta
			
			if target_body.global_position.x < global_position.x:
				print("target x < x")
				#$AnimatedSprite2D.flip_h = true
			else:
				print("target x > x")
				#$AnimatedSprite2D.flip_h = false
		move_and_collide(Vector2(0,0))

func handle_animation_tree():
	pass

func _on_health_component_died() -> void:
	queue_free()

func handle_attack():
	attack_component.get_parent_damage(stat_component.Damage)

func _on_hitbox_component_receive_damage(damage: int) -> void:
	healthbar.health = health_component.reduce_health(damage)


func _on_detection_area_body_entered(body: Node2D) -> void:
	target_body = body


func _on_detection_area_body_exited(body: Node2D) -> void:
	target_body = null
