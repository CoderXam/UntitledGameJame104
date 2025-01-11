extends Node2D

@export var rounds = 10

signal roundEnd(roundsLeft: int)
signal roundStart()



# Called when the node enters the scene tree for the first time.
func _ready():
	
	Global.resetPos(18)

	#var PlayerHealth = $PlayerData.get("PlayerHealth")
	#print(PlayerHealth)
	$roundCounter.text = "Rounds Left: %d" % rounds


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		#all the code ones on one thread, so only once everything that _on_round_end() affects
		#is done, will it move onto the next thing in this line
		#(at least that's how i think it works, and it's good for now --jacob)
		_on_round_end()
		#resets the array that stores where enemies can move to or not
		Global.resetPos(18)
		#just a signal to let everything know to go add its state to the global position array
		#(that's all it does for now, might end up doing more later --jacob)
		_on_round_start()
	
	pass



"""
MAKE SURE TO MANUALLY CONNECT THE endRound and startRound SIGNAL TO ALL OTHER INSTANCED SCENES
WITHIN THIS SCENE, OR ELSE A BUNCH OF STUFF WONT WORK LOL --JACOB
"""
func _on_round_end():
	if rounds == 0:
		return
	
	rounds -= 1
	roundEnd.emit(rounds)
	$roundCounter.text = "Rounds Left: %d" % rounds
	#print("test end scene")

func _on_round_start():
	roundStart.emit()
