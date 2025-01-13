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
