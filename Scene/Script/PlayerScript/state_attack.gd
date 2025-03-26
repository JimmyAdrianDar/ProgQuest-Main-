class_name State_Attack extends State

@onready var idle: State_Idle = $"../Idle"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var run: State_Run = $"../Run"

var attacking : bool = false

func Enter() -> void:
	player.UpdateAnimation("attack")
	animation_player.animation_finished.connect( EndAttack )
	attacking = true
	pass

func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack )
	attacking = false
	pass

func Process( _delta : float) -> State:
	player.direction = Vector2.ZERO
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return run
	return null

func Physics( _delta : float) -> State:
	return null

func HandleInput( _event : InputEvent) -> State:
	return null

func EndAttack( _newAnimName : String ) -> void:
	attacking = false
