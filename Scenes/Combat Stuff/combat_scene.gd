extends Node2D

@export var maxRounds = 10


signal roundEnd(roundsLeft: int)
signal roundStart()

@onready var rounds = maxRounds
@onready var healthBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():

	healthBar.value = 100
	
	Global.resetPos()

	#var PlayerHealth = $PlayerData.get("PlayerHealth")
	#print(PlayerHealth)
	$roundCounter.text = "Rounds Left: %d" % rounds
	
	refresh_inventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		#all the code ones on one thread, so only once everything that _on_round_end() affects
		#is done, will it move onto the next thing in this line
		#(at least that's how i think it works, and it's good for now --jacob)
		_on_round_end()
		#resets the array that stores where enemies can move to or not
		Global.resetPos()
		#just a signal to let everything know to go add its state to the global position array
		#(that's all it does for now, might end up doing more later --jacob)
		_on_round_start()
	

@onready var inv_slots = [$Runes/Rune/Sprite2D, $Runes/Rune2/Sprite2D, $Runes/Rune3/Sprite2D, $Runes/Rune4/Sprite2D, $Runes/Rune5/Sprite2D, $Runes/Rune6/Sprite2D, $Runes/Rune7/Sprite2D, $Runes/Rune8/Sprite2D, $Runes/Rune9/Sprite2D]
# Displays list of items in inventory (copied forom shop code)
func refresh_inventory() -> void:
	for i in inv_slots:
		i.hide()
	for i in len(PlayerData1.inventory):
		inv_slots[i].texture = PlayerData1.inventory[i].image
		inv_slots[i].show()

"""
MAKE SURE TO MANUALLY CONNECT THE endRound and startRound SIGNAL TO ALL OTHER INSTANCED SCENES
WITHIN THIS SCENE, OR ELSE A BUNCH OF STUFF WONT WORK LOL --JACOB
"""

func _on_round_end():
	if rounds == 0:
		return
	
	
	rounds -= 1
	healthBar.value -= 100/(maxRounds-1)
	roundEnd.emit(rounds)
	$roundCounter.text = "Rounds Left: %d" % rounds
	#print("test end scene")

func _on_round_start():
	roundStart.emit()


func _on_area_2d_mouse_entered() -> void:
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	pass # Replace with function body.
