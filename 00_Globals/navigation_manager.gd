extends Node

const scene_game = preload("res://game.tscn")
const scene_boss_fight = preload("res://TileSet/boss_fight.tscn")
const scene_swamp = preload("res://TileSet/node_2d.tscn")


signal on_trigger_player_spawn

var spawn_door_tag
var howmanytimes : int = 0

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"game":
			scene_to_load = scene_game
		"boss_fight":
			scene_to_load = scene_boss_fight
		"Game":
			scene_to_load = scene_game
		"swamp":
			scene_to_load = scene_swamp
		
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		call_deferred("change_scene_safely", scene_to_load)
	else:
		print("Error: Scene for", level_tag, "not found!")
	
	how_many_goes_to_game(scene_to_load)

func how_many_goes_to_game(scene_to_load):
	if scene_to_load == scene_game:
		howmanytimes += 1

# Function to handle scene change safely
func change_scene_safely(scene_to_load):
	get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
