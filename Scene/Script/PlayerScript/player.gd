class_name Player extends CharacterBody2D

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

@onready var health_component = $HealthComponent
@onready var stat_component: Node2D = $StatComponent
@onready var attack_component = $AttackComponent
@onready var healthbar: ProgressBar = $"CanvasLayer/inGameUI/Healthbar"
@onready var joystick: Node2D = $"CanvasLayer/inGameUI/Joystick"
@onready var ui_control: Control = $"CanvasLayer/inGameUI"
@onready var bag: TouchScreenButton = $CanvasLayer/inGameUI/Bag
@onready var exitbutton: TouchScreenButton = $CanvasLayer/inGameUI/exitbutton

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_sprite: Sprite2D = $SpriteHolder/AnimationSprite
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var attack_collision_shape_2d: CollisionShape2D = $AttackComponent/CollisionShape2D


var direction : Vector2 = Vector2.ZERO
var idle
var cardinal_direction : Vector2 = Vector2.DOWN

var navigation_target_postion: Vector2 = Vector2.ZERO
var next_path_position: Vector2 = Vector2.ZERO
var slime_killed : int = 0

func _ready() -> void:
	state_machine.Initialize(self)
	PlayerManager.player = self
	healthbar.init_health(health_component.check_health())
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)

func _process(delta):
	handle_attack()
	

#Movement Mechanics
func _physics_process(delta: float) -> void:
#---------Official Movement Code With Joystick-----------
	#direction = joystick.posVector
	###print(direction)
	#if direction:
		#direction = direction.normalized()
		#velocity = direction * stat_component.Speed
	#else:
		#velocity = Vector2.ZERO
	#move_and_slide()
	
#-----------Debug Movement Code----------
	direction = Input.get_vector("ui_a", "ui_d", "ui_w", "ui_s").normalized()
	#if direction:
		#velocity = direction * stat_component.Speed
	#else:
		#velocity = Vector2.ZERO
	
	
	move_and_slide()
	
	if navigation_target_postion != Vector2.ZERO:
		# Only update navigation when the target changes
		if navigation_agent_2d.target_position != navigation_target_postion:
			navigation_agent_2d.target_position = navigation_target_postion
			next_path_position = navigation_agent_2d.get_next_path_position()

		# Check if navigation is complete
		if navigation_agent_2d.is_navigation_finished():
			navigation_target_postion = Vector2.ZERO
			

func dialogue_ui_visibility(ui_visible : bool):
	if ui_visible == true:
		$CanvasLayer/inGameUI/Joystick.visible = ui_visible
		$CanvasLayer/inGameUI/Attack.visible = ui_visible
		$CanvasLayer/inGameUI/Interact.visible = ui_visible
	elif ui_visible == false:
		$CanvasLayer/inGameUI/Joystick.visible = ui_visible
		$CanvasLayer/inGameUI/Attack.visible = ui_visible
		$CanvasLayer/inGameUI/Interact.visible = ui_visible
		

func all_control_viisbility(visibility_of_ui : bool):
	if visibility_of_ui == true:
		$CanvasLayer.visible = visibility_of_ui
	elif visibility_of_ui == false:
		$CanvasLayer.visible = visibility_of_ui

func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	#Making sure that the angle is converted from 360 to the number of const converted to an array
	var direction_id : int = int( round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()) )
	var new_dir = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	animation_sprite.scale.x = 1 if cardinal_direction == Vector2.LEFT else -1
	attack_collision_shape_2d.position.x = -21 if cardinal_direction == Vector2.LEFT else 21
	attack_collision_shape_2d.position.y = -8.75
	return true

func UpdateAnimation( state : String ) -> void:
	animation_player.play(state + "_" + AnimDirection())
	pass

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func handle_attack():
	if Input.is_action_just_pressed("attack"):
		attack_component.get_parent_value(stat_component.Damage)

#Perform function when hp == 0
func _on_health_component_died() -> void:
	pass

func update_hp(heal_amount):
	if heal_amount != null:
		print(heal_amount) 

func _on_hitbox_component_receive_damage(damage: int) -> void:
	healthbar.health = health_component.reduce_health(damage)

func quest_arrow_target_position(x : float, y : float):
	var position = Vector2(x,y)
	
	$CanvasLayer/QuestMarker.quest_target_position = position

func quest_arrow_visibility(is_visible : bool):
	if is_visible == false:
		$CanvasLayer/QuestMarker.visible = is_visible
	elif is_visible == true:
		$CanvasLayer/QuestMarker.visible = is_visible

#Handles door system spawn
func _on_spawn(position: Vector2, direction: String):
	global_position = position

func ui_disable(disable : bool):
	if disable == true:
		ui_control.visible = false
	elif disable == false:
		ui_control.visible = true

func player_slime_killed(count : int) -> void:
	slime_killed += count
