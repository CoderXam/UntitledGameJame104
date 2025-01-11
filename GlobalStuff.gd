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

#Normally x should be 18
func resetPos(x):
	for i in range(x):
		charPositions.append(0)
