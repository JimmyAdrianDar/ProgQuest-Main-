extends TileMap

@onready var boss_collision_shape: CollisionShape2D = %CollisionShape2D510

func _process(delta: float) -> void:
	get_collision_for_boss()

func get_collision_for_boss():
	boss_collision_shape.disabled = true
