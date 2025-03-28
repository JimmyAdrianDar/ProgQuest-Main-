class_name EnemyStateDestroy extends EnemyState

@export var anim_name : String = "death"
@export var knockback_speed : float = 300.0
@export var develerate_speed : float = 10.0

@export_category("AI")

var _direction : Vector2

func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	pass

func enter() -> void:
	_direction = enemy.global_position.direction_to(enemy.player.global_position)
	
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed
	
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	pass

func exit() -> void:
	pass

func process (_delta : float) -> EnemyState:
	enemy.velocity -= enemy.velocity * develerate_speed * _delta
	return null

func physics(_delta : float) -> EnemyState:
	return null

func _on_enemy_destroyed() -> void:
	state_machine.change_state(self)

func _on_animation_finished( _a : String ) -> void:
	PlayerManager.player.player_slime_killed(1)
	enemy.queue_free()
