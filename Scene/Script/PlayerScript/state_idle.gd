class_name State_Idle extends State

@onready var run: State_Run = $"../Run"
@onready var attack: State_Attack = $"../Attack"


func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

func Exit() -> void:
	pass

func Process( _delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return run
	player.velocity = Vector2.ZERO
	return null

func Physics( _delta : float) -> State:
	return null

func HandleInput( _event : InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
