extends Sprite2D

@onready var parent: Node2D = $".."

var pressing : bool = false

@export var maxLength = 50
@export var deadZone = 5

func _ready() -> void:
	maxLength *= parent.scale.x

func _process(delta: float) -> void:
	if pressing:
		if get_global_mouse_position().distance_to(parent.global_position) <= maxLength:
			global_position = get_global_mouse_position()
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position.x = parent.global_position.x + cos(angle) * maxLength
			global_position.y = parent.global_position.y + sin(angle) * maxLength
		calculateVector()
	else:
		global_position = lerp(global_position, parent.global_position, delta * 10)
		parent.posVector = Vector2(0,0)

#Calculates the vector interms of where the knob is position
func calculateVector():
	var raw_vector = Vector2(
		(global_position.x - parent.global_position.x) / maxLength,
		(global_position.y - parent.global_position.y) / maxLength
	)
	
	# Determine the dominant direction
	if abs(raw_vector.x) > abs(raw_vector.y):
		parent.posVector = Vector2(raw_vector.x, 0)  # Snap to horizontal
	else:
		parent.posVector = Vector2(0, raw_vector.y)  # Snap to vertical

func _on_button_button_down() -> void:
	pressing = true

func _on_button_button_up() -> void:
	pressing = false
