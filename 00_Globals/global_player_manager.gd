extends Node

var player : Player
const INVENTORY_DATA : InventoryData = preload("res://Resources/InventoryResources/player_inventory.tres")

var xp : int = 0

func set_health( hp: int, max_hp: int ) -> void:
	player.max_hp = max_hp
	player.hp = hp
	player.update_hp( 0 )

func reward_xp( _xp : int ) -> void:
	xp += _xp
	print( "XP = ", str(xp))
	# check for level advancement
	#check_for_level_advance()


# Check for level advance, recursively.
# A recursive function will call itself under certain conditions,
# and will NOT call itself under other conditions, known as a base condition.
# An exit or base condition that stops the recursion is essential, 
# otherwise the function will call itself indefinitely and lock up the program 
#func check_for_level_advance() -> void:
	#if player.level >= level_requirements.size():
		#return
	#if player.xp >= level_requirements[ player.level ]:
		#player.level += 1
		#player.attack += 1
		#player.defense += 1
		#player_leveled_up.emit()
		#check_for_level_advance()
	#pass
