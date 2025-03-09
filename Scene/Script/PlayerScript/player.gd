class_name Player extends CharacterBody2D

@onready var health_component = $HealthComponent
@onready var stat_component: Node2D = $StatComponent
@onready var attack_component = $AttackComponent
@onready var healthbar: ProgressBar = $"User Interface Design/Control/Healthbar"
@onready var joystick: Node2D = $"User Interface Design/Control/Joystick"
@onready var quiz: Control = $"User Interface Design/Quiz"
@onready var ui_control: Control = $"User Interface Design/Control"
@onready var book_1: book = $"User Interface Design/Book"
@onready var book_2: Control = $"User Interface Design/Book2"
@onready var book_3: Control = $"User Interface Design/Book3"

@onready var animation_tree : AnimationTree = $AnimationTree

var direction : Vector2
var idle

func _ready() -> void:
	PlayerManager.player = self
	animation_tree.active = true
	quiz.visible = false
	healthbar.init_health(health_component.check_health())

func _process(delta):
	update_animation_parameters()
	handle_attack()

#Movement Mechanics
func _physics_process(delta: float) -> void:

#---------Official Movement Code With Joystick-----------
	#direction = joystick.posVector
	#if direction:
		#velocity = direction * stat_component.Speed
	#else:
		#velocity = Vector2.ZERO
	#move_and_slide()
	
#-----------Debug Movement Code----------
	direction = Input.get_vector("ui_a", "ui_d", "ui_w", "ui_s").normalized()
	
	if direction:
		velocity = direction * stat_component.Speed
	else:
		velocity = Vector2.ZERO
	
	
	move_and_slide()

func update_animation_parameters():
	#-----------Animation Tree Conditionals---------
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

#---------Animation Tree Blend Position-----------
	if direction != Vector2.ZERO:
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Walk/blend_position"] = direction
		animation_tree["parameters/Slash/blend_position"] = direction.x

func handle_attack():
	if Input.is_action_just_pressed("attack"):
		attack_component.get_parent_value(stat_component.Damage)

#func receive_swimming_notification(receive_swimming):
	#if receive_swimming != null:
		#is_swimming = receive_swimming
	#else:
		#is_swimming = null

#Perform function when hp == 0
func _on_health_component_died() -> void:
	pass

func update_hp(heal_amount):
	if heal_amount != null:
		print(heal_amount) 

func _on_hitbox_component_receive_damage(damage: int, knockback) -> void:
	healthbar.health = health_component.reduce_health(damage)

func handle_quiz(on_visible : bool):
	if on_visible == true:
		quiz.visible = true
		ui_control.visible = false
	elif on_visible == false:
		quiz.visible = false
		ui_control.visible = true
	else:
		print("error in quiz")

func handle_book(on_visible : bool):
	if on_visible == true:
		book_1.visible = true
		ui_control.visible = false
	elif on_visible == false:
		ui_control.visible = true
