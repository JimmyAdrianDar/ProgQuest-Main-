extends Node2D

signal give_quest

@onready var interactive_area: InteractionArea = $InteractionArea 
@onready var sprite = $Sprite2D
@onready var player: Player = $"../Player"
@onready var canvas_layer: CanvasLayer = $CanvasLayer

var has_quest : bool = false
var interact_count : int = 0
@onready var book: book = $CanvasLayer/Book


func _ready() -> void:
	interactive_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if interact_count == 0:
		Dialogic.start("marcosdialogue")
		interact_count += 1
		return
	if interact_count == 1:
		PlayerManager.player.ui_disable(true)
		book.visible = true
		interact_count += 1
