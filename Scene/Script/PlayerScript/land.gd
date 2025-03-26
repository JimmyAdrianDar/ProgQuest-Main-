extends TileMap

@onready var navigation: TileMapLayer = $Land
@onready var obstacles: TileMapLayer = $"Trees Fill"

func _ready():
	set_navigation_exceptions()

func set_navigation_exceptions():
	# Get all obstacles (trees, water, etc.)
	for coords in obstacles.get_used_cells():
		set_cell(0, coords, -1)  # Disable navigation for these tiles
