extends Control

signal shown
signal hide_inventory

var is_paused : bool = false

@onready var audio_stream_player: AudioStreamPlayer = $CanvasLayer/Parent_canvas/AudioStreamPlayer
@onready var item_description: Label = $CanvasLayer/Parent_canvas/ItemDescription
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var button: Button = $CanvasLayer/Parent_canvas/Button

func _ready() -> void:
	visible = true
	hide_inventory_menu()
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("bag"):
		if is_paused == false:
			show_inventory_menu()
		else:
			hide_inventory_menu()
		get_viewport().set_input_as_handled()

func show_inventory_menu() -> void:
	#get_tree().paused = true
	canvas_layer.visible = true
	is_paused = true
	#button.grab_focus()
	shown.emit()

func hide_inventory_menu() -> void:
	#get_tree().paused = false
	canvas_layer.visible = false
	is_paused = false
	hide_inventory.emit()

func update_item_description( new_text : String ) -> void:
	item_description.text = new_text

#func play_audio(audio : AudioStream) -> void:
	#audio_stream_player.stream = audio
	#audio_stream_player.play()
