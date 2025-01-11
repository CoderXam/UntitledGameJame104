extends Node2D

@export var health = 10
enum CharacterState {
	MOVING = 0,
	STUCK = 1
}

var currentState = CharacterState.STUCK

const tileSize = Global.tileSize
var moving = false
var direction = Vector2(-1,0)
var arrPos  

# Called when the node enters the scene tree for the first time.
func _ready():
	var CombatScene = get_node("../")
	#print(CombatScene.get_signal_list())
	#print("loaded")
	
	position. y = 120
	arrPos = floor(position.x / 64)
	print(arrPos)
	position.x = arrPos * 64


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



"""
FOR THIS TO WORK, YOU MUST MANUALLY CONNECT THE roundEnd and roundStart SIGNAL 
TO THE CHARACTER IN EACH SEPERATE COMBAT SCENE. THERE SHOULD BE A LITTLE GREEN ARROW
ON THE LEFT OF THE FUNCTION DECLARATION WHEN VIEWING THE SCRIPT FROM THE DESIRED SCENE

IF NOT SURE HOW/WHAT TO DO FOR THIS, ASK JACOB
SORRY THIS IS INCONVENIENT, BUT I COULDN'T GET IT TO WORK ANY OTHER WAY
"""
func _on_combat_scene_round_end(roundsLeft):
	pass # Replace with function body.


func _on_combat_scene_round_start():
	#sets the state of this instance into the global position array
	#allows other enemies to see whether they'll be allowed to move here or not
	Global.charPositions[arrPos] = currentState
