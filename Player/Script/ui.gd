extends Control

@onready var interact = $CanvasLayer/Interact
@onready var attack = $CanvasLayer/Attack

func _ready() -> void:
	interact.visible = false

func _process(delta: float) -> void:
	if Global.player_interacting == true:
		interact_visible()
	else:
		attack_visible()

func attack_visible():
	attack.visible = true
	interact.visible = false

func interact_visible():
	attack.visible = false
	interact.visible = true
