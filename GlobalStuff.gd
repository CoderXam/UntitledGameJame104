extends Node

"""
COMBAT SCENE WORKSPACE
"""

const tileSize = 64
var charPositions = []
enum CharacterState {
	MOVING,
	STUCK,
	PLAYER
}


#Normally x should be 9
func resetPos(x = 9):
	for i in range(x):
		charPositions.append(0)


#For runes
var is_dragging = false

# For switching scenes (for debugging purposes, should be deleted when game is finished)
var scenes = ["res://Scenes/MapScene.tscn",
"res://Scenes/Combat Stuff/CombatScene.tscn",
"res://Scenes/shop/shop_scene.tscn"]
var scene_index:int

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("switch_scene") and scene_index<scenes.size()-1:
		scene_index += 1
		get_tree().change_scene_to_file(scenes[scene_index])
		print("switched to " + scenes[scene_index])
	elif event.is_action_pressed("switch_scene"):
		scene_index = 0
		get_tree().change_scene_to_file(scenes[scene_index])
		print("switched to " + scenes[scene_index])

func _ready():
	for i in len(scenes):
		if get_tree().current_scene.scene_file_path == scenes[i]:
			scene_index = i
