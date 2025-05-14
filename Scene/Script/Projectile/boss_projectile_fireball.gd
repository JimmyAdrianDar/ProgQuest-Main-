extends CharacterBody2D

var _TARGET
var max_speed : float = 5.0
var SPEED : int = 100

var spawnPos : Vector2

func _ready() -> void:
	_TARGET = PlayerManager.player
	global_position = spawnPos

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, -SPEED)
	move_and_slide()
	
	if !_TARGET:
		position += max_speed * Vector2.RIGHT.rotated(rotation) * delta
		return
		
	print("Target is seen")
	look_at(_TARGET.global_position)
	position = position.move_toward(_TARGET.global_position, max_speed)
	

#Deal damage and clear itself
	if position == _TARGET.global_position:
		_TARGET._on_hitbox_component_receive_damage(10)
		move_and_collide(Vector2())
		queue_free()
