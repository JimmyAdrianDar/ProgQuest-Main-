extends CharacterBody2D
signal landed

var question_data : Dictionary = {}
@onready var meteor_state_machine: EnemyStateMachine = $MeteorStateMachine

func _ready() -> void:
	meteor_state_machine.initialize(self)

func land():
	emit_signal("landed") 

func _physics_process(delta: float) -> void:
	print(position)
