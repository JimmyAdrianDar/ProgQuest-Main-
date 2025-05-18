class_name MinionStateIdle extends EnemyState

@export var anim_name : String = ""

@export_category("AI")
@export var after_idle_state : EnemyState
@onready var minions : Minion = $"../.."

var player = Player

var minions_position
var player_position
var distance_between_player

var player_is_near : bool = false

func init() -> void:
	pass

func enter() -> void:
	minions.velocity = Vector2.ZERO		
	if distance_between_player <= 60.0:
		print("PlayerIsnear")
		player_is_near = true
	enemy.update_animation(anim_name)
	pass

func exit() -> void:
	pass

func process (_delta : float) -> EnemyState:
	player = PlayerManager.player
	minions_position = minions.position
	player_position = player.position
	distance_between_player = minions.position.distance_to(player.position)
	if player_is_near == true:
		return after_idle_state
	return null

func physics(_delta : float) -> EnemyState:
	return null
