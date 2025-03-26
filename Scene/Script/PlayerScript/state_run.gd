class_name State_Run extends State

@export var stat_component : Node2D

@onready var idle: State_Idle = $"../Idle"
@onready var attack: State_Attack = $"../Attack"


func Enter() -> void:
	player.UpdateAnimation("run")
	pass

func Exit() -> void:
	pass

func Process( _delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * stat_component.Speed
	
	if player.SetDirection():
		player.UpdateAnimation("run")
	return null

func Physics( _delta : float) -> State:
	return null

func HandleInput( _event : InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
