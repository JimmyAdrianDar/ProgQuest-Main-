extends CharacterBody2D

@onready var healthbar = $"User Interface Design/Healthbar"
@onready var health_component = $HealthComponent
@onready var stat_component = $StatComponent
@onready var attack_component = $AttackComponent

@onready var animation_tree : AnimationTree = $AnimationTree

var direction : Vector2 = Vector2.ZERO
var idle

func _ready() -> void:
	animation_tree.active = true
	healthbar.init_health(health_component.check_health())

func _process(delta):
	update_animation_parameters()
	handle_attack()

#Movement mechanics
func _physics_process(delta: float) -> void:
	direction = Input.get_vector("ui_a", "ui_d", "ui_w", "ui_s").normalized()
	
	if direction:
		velocity = direction * stat_component.Speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	#-------- Previous Movement Code -------
	#var velocity = Vector2.ZERO
	#
	#if Input.is_action_pressed("up") || Input.is_action_pressed("ui_w"):
		#velocity.y -= stat_component.Speed
	#if Input.is_action_pressed("down") || Input.is_action_pressed("ui_s"):
		#velocity.y += stat_component.Speed
	#if Input.is_action_pressed("left") || Input.is_action_pressed("ui_a"):
		#velocity.x -= stat_component.Speed
	#if Input.is_action_pressed("right") || Input.is_action_pressed("ui_d"):
		#velocity.x += stat_component.Speed
	#
	#position += velocity * delta
	#
	#move_and_collide(Vector2(0,0))

func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
	
	if Input.is_action_just_pressed("attack"):
		animation_tree["parameters/conditions/is_attacking"] = true
	else:
		animation_tree["parameters/conditions/is_attacking"] = false
		
	if direction != Vector2.ZERO:
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Walk/blend_position"] = direction
		animation_tree["parameters/Slash/blend_position"] = direction.x

func handle_attack():
	if Input.is_action_just_pressed("attack"):
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
