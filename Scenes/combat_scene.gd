extends Node2D

@export var rounds = 10

signal roundEnd(roundsLeft: int)



# Called when the node enters the scene tree for the first time.
func _ready():
	
	Global.resetPos(18)

	var PlayerHealth = $PlayerData.get("PlayerHealth")
	#print(PlayerHealth)
	$roundCounter.text = "Rounds Left: %d" % rounds


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		_on_round_end()
		#print("round end")
	
	pass



"""
MAKE SURE TO MANUALLY CONNECT THE endRound SIGNAL TO ALL OTHER INSTANCED SCENES
WITHIN THIS SCENE, OR ELSE A BUNCH OF STUFF WONT WORK LOL --JACOB
"""
func _on_round_end():
	#if rounds == 0:
		#return
	
	rounds -= 1
	roundEnd.emit(rounds)
	$roundCounter.text = "Rounds Left: %d" % rounds
	
	#print("test end scene")
