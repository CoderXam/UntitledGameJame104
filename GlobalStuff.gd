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


#"""
#RUNES
#"""
#var is_dragging = false


"JACOBS FIX, WILL CLEAN UP ONCE IM DONE"
var isClicked = false
var hasSelection = false
var newRunePos

#turns into an array of 9 0s in _ready(), to represent the rune slots and dropped spots
var runeArr = []
var spotArr = []




# For switching scenes (for debugging purposes, should be deleted when game is finished)
var fire: Rune = Rune.new("Fireball","Launch a scorching fireball attack",preload("res://Sprites/runes/fire.png"),5,15)
var magma := Rune.new("Magma Stomp","Turn the ground to molten rock", preload("res://Sprites/runes/magma.png"),5,15)
var water := Rune.new("Water Blast","Blast foes back and deal damage with a pressurized beam of water", preload("res://Sprites/runes/water.png"),5,15)
var shield := Rune.new("Shield","Block incoming attacks with an arcane ward", preload("res://Sprites/runes/shield.png"),5,15)
var orb := Rune.new("Orb","Pierce through enemies with a spectral orb", preload("res://Sprites/runes/orb.png"),5,5)
var lifesteal := Rune.new("Lifesteal","Sap away the lifeforce of enemies for yourself", preload("res://Sprites/runes/lifesteal.png"),5,10)
var root := Rune.new("Root Snatch","Fix enemies in place with grasping roots", preload("res://Sprites/runes/root.png"),5,5)
var lightning := Rune.new("Lightning Bolt","Shock and stun enemies with a bolt of lightning", preload("res://Sprites/runes/lightning.png"),5,5)
var amplify := Rune.new("Amplify","Amplify other runes", preload("res://Sprites/runes/amplify.png"),5,5)
var thorns := Rune.new("Thorn Needles","Riddle your enemies with thorny needles", preload("res://Sprites/runes/thorns.png"),5,10)
var EMPTY := Rune.new("empty","placeholder rune")

var RUNE_POOL = [fire,magma,water,shield,orb,lifesteal,root,lightning,amplify,thorns]

"""
SCENE SWITCHING
"""

var scenes = ["res://Scenes/MapScene.tscn",
"res://Scenes/Combat Stuff/CombatScene.tscn",
"res://Scenes/shop/shop_scene.tscn"]
var scene_index:int

func _ready():
	
	#for the rune casting system
	for i in range(9):
		runeArr.append(0)
		spotArr.append(0)

	
	# Get the current scene
	for i in len(scenes):
		if get_tree().current_scene.scene_file_path == scenes[i]:
			scene_index = i


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("switch_scene") and scene_index<scenes.size()-1:
		scene_index += 1
		get_tree().change_scene_to_file(scenes[scene_index])
		print("switched to " + scenes[scene_index])
	elif event.is_action_pressed("switch_scene"):
		scene_index = 0
		get_tree().change_scene_to_file(scenes[scene_index])
		print("switched to " + scenes[scene_index])
