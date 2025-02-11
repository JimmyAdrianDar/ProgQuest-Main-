extends CharacterBody2D

@onready var healthbar = $"User Interface Design/Healthbar"
@onready var health_component = $HealthComponent
@onready var stat_component = $StatComponent
@onready var attack_component = $AttackComponent

@onready var animation_tree = $AnimationTree

var is_swimming
var is_attacking
var last_facing_direction := Vector2(0, -1)
var idle

func _ready() -> void:
	healthbar.init_health(health_component.check_health())

func _process(delta):
	input_movement(delta)
	handle_attack()

func input_movement(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("up") || Input.is_action_pressed("ui_w"):
		velocity.y -= stat_component.Speed
	if Input.is_action_pressed("down") || Input.is_action_pressed("ui_s"):
		velocity.y += stat_component.Speed
	if Input.is_action_pressed("left") || Input.is_action_pressed("ui_a"):
		velocity.x -= stat_component.Speed
	if Input.is_action_pressed("right") || Input.is_action_pressed("ui_d"):
		velocity.x += stat_component.Speed
	
	position += velocity * delta
	
	move_and_collide(Vector2(0,0))
	
	if velocity:
		last_facing_direction = velocity.normalized()
	
	idle = !velocity
	
	animation_tree.set("parameters/idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/run/blend_position", last_facing_direction)
	animation_tree.set("parameters/swim/blend_position", last_facing_direction)

func handle_attack():
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		attack_component.get_parent_damage(stat_component.Damage)

#func receive_swimming_notification(receive_swimming):
	#if receive_swimming != null:
		#is_swimming = receive_swimming
	#else:
		#is_swimming = null

func _on_health_component_died() -> void:
	pass

func _on_hitbox_component_receive_damage(damage: int) -> void:
	healthbar.health = health_component.reduce_health(damage)
