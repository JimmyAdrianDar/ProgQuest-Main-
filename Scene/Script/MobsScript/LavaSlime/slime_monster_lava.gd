class_name LavaSlime extends CharacterBody2D

signal direction_changed(new_direction:Vector2)
signal enemy_damaged()
signal enemy_on_sight()
signal enemy_destroyed()

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var healthbar = $Healthbar
@onready var health_component = $HealthComponent
@onready var enemy_stat_component: Node2D = $StatComponent
@onready var attack_component = $AttackComponent
@onready var sprite: Sprite2D = $SpriteContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: EnemyStateMachine = $EnemyStateMachine

var cardinal_direction: Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invulnerable : bool = false

var is_on_cooldown: bool = false
var cooldown_timer: Node2D
var receive_knockback

func _ready() -> void:
	healthbar.init_health(health_component.check_health())
	state_machine.initialize(self)
	player = PlayerManager.player

func _process(delta: float) -> void:
	handle_attack()

func _physics_process(delta: float) -> void:
	#---------calculating the distance between player and slime--------------
	
	var player_position = player.global_position
	var direction_to_player = (player_position - global_position).normalized()
	var distance_to_player = global_position.distance_to(player_position)
	if distance_to_player < 330.0: #300.0 is the camera distance from character to end of pov
		if distance_to_player < 150.0:
			pass
	
	#if target_body != null:
		#if position.distance_to(target_body.position) > 10:
			#var direction = (target_body.global_position - global_position).normalized()
			#global_position += direction * stat_component.Speed * delta
			#if receive_knockback != null:
				#global_position += receive_knockback
				#receive_knockback = null
		#move_and_collide(Vector2(0,0))
	move_and_slide()

#Setting the cardinal direction of the slime
func set_direction(_new_direction: Vector2) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round(
		(direction + cardinal_direction * 0.1).angle()
		/ TAU * DIR_4.size()
	))
	var new_dir = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func update_animation(state:String) -> void:
	animation_player.play(state + "_" + anim_direction())
	pass

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

#For slime animation blend
func handle_animation_tree():
	pass

func _on_health_component_died() -> void:
	emit_signal("enemy_destroyed")

func handle_attack():
	attack_component.get_parent_value(enemy_stat_component.Damage)

func _on_hitbox_component_receive_damage(damage: int) -> void:
	emit_signal("enemy_damaged")
	healthbar.health = health_component.reduce_health(damage)
