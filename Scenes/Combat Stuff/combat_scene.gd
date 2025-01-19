extends Node2D

#@export var maxRounds = 10


#signal roundEnd(roundsLeft: int)
#signal roundStart()

#@onready var rounds = maxRounds
#@onready var healthBar = $ProgressBar

@onready var support = $AttackList/AttackSupport

# Called when the node enters the scene tree for the first time.
func _ready():
	print("COMBAT_SCENE READY")
	for i in Global.attack:
		i=Global.EMPTY
	
	#healthBar.value = 100
	
	Global.resetPos()

	#var PlayerHealth = $PlayerData.get("PlayerHealth")
	#print(PlayerHealth)
	#$roundCounter.text = "Rounds Left: %d" % rounds


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#if Input.is_action_just_pressed("ui_accept"):
		##all the code ones on one thread, so only once everything that _on_round_end() affects
		##is done, will it move onto the next thing in this line
		##(at least that's how i think it works, and it's good for now --jacob)
		#_on_round_end()
		##resets the array that stores where enemies can move to or not
		#Global.resetPos()
		##just a signal to let everything know to go add its state to the global position array
		##(that's all it does for now, might end up doing more later --jacob)
		#_on_round_start()
	
	support.text = "Support spells:\n"
	for i in len(Global.attack)-2:
		if Global.attack[i] != Global.EMPTY:
			support.text += Global.attack[i].rune_name+"\n"
	
	$AttackList/Main/MainAttack.text = Global.attack[len(Global.attack)-2].rune_name
	$AttackList/Main/MainAttack.add_theme_color_override("default_color", Global.attack[len(Global.attack)-2].color)
	

@onready var inv_slots = [$Runes/Rune, $Runes/Rune2, $Runes/Rune3, $Runes/Rune4, $Runes/Rune5, $Runes/Rune6, $Runes/Rune7, $Runes/Rune8, $Runes/Rune9]

# Loads the textures for the runes in the rune pool
func refresh_pool() -> void:
	print("refresh")
	
	# Generate rune pool
	PlayerData1.rune_pool = []
	for i in 4:
		PlayerData1.rune_pool.append(PlayerData1.inventory[randi_range(0,PlayerData1.inventory.size()-1)])
	
	for i in len(inv_slots):
		var tweenMove = create_tween()
		tweenMove.tween_property(inv_slots[i], "global_position", Global.runeArr[i], 0.1)
		inv_slots[i].hide()
	for i in len(PlayerData1.rune_pool):
		inv_slots[i].get_child(1).texture = PlayerData1.rune_pool[i].image
		inv_slots[i].get_child(1).scale = Vector2(0.75,0.75) # THIS IS TO ADJUST THE NEW IMAGE SCALE FOR THE RUNES
		inv_slots[i].show()
	
	for i in inv_slots:
		i._ready()

"""
MAKE SURE TO MANUALLY CONNECT THE endRound and startRound SIGNAL TO ALL OTHER INSTANCED SCENES
WITHIN THIS SCENE, OR ELSE A BUNCH OF STUFF WONT WORK LOL --JACOB
"""

#func _on_round_end():
	#if rounds == 0:
		#return
	#
	#
	#rounds -= 1
	#healthBar.value -= 100/(maxRounds-1)
	#roundEnd.emit(rounds)
	#$roundCounter.text = "Rounds Left: %d" % rounds
	##print("test end scene")
#
#func _on_round_start():
	#roundStart.emit()


func _on_area_2d_mouse_entered() -> void:
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	pass # Replace with function body.
