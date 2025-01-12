extends Node2D
	
#0 pos in array = name, 1 = description, 2 = price, 3 = probability of showing up
var shop_inv = {"Fire": ["Fireball","Launch a scorching fireball attack", 5, 10],
 				"Magma" : ["Magma","Turn the ground to molten rock", 5, 10],
			 	"Water" : ["Water Blast","Blast foes back and deal damage with a pressurized beam of water", 5, 10],
				"Shield" : ["Shield","Block incoming attacks with an arcane ward", 5, 10],
			 	"Orb" : ["Orb","Pierce through enemies with a spectral orb", 5, 10],
				"Lifesteal" : ["Lifesteal","Sap away the lifeforce of enemies for yourself", 5, 10], 
				"Root" : ["Root Snatch","Fix enemies in place with grasping roots", 5, 10],
				"Lightning" : ["Lightning Bolt","Shock and stun enemies with a bolt of lightning", 5, 10], 
				"Amplify" : ["Amplify","Amplify other runes", 5, 10], 
				"Thorn" : ["Thorn Needles","Riddle your enemies with thorny needles", 5, 10]}
# Called when the node enters the scene tree for the first time.

var pool = [shop_inv["Fire"],shop_inv["Magma"],shop_inv["Water"],shop_inv["Shield"],shop_inv["Orb"],shop_inv["Lifesteal"],shop_inv["Root"],shop_inv["Lightning"],shop_inv["Amplify"],shop_inv["Thorn"],]
var available = []
var randnum = 0
var names = []
var desc = []

func _ready() -> void:
	names = [$rune1/name,$rune2/name,$rune3/name,$rune4/name]
	desc = [$rune1/description,$rune2/description,$rune3/description,$rune4/description]
	
	for i in 4: # Generate rune for each slot in the shop
		randnum = randi_range(1,100)
		for j in 10:
			# If random number is between 1-10, choose the 1st spell
			# If randum number is between 2-20 choose the 2nd spell
			# etc. (This only works since probabilities are equally distributed)
			if randnum > j*10 and randnum < (j+1)*10+1:
				available.append(pool[j])
		
		print(str(i+1)+". "+available[i][0])
		names[i].text = available[i][0]
		desc[i].text = available[i][1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_rune_1_pressed() -> void:
	PlayerData1.currency -= available[0][2]
	print("pruchased " + available[0][0])
	print("currency: "+ str(PlayerData1.currency))
	pass # Replace with function body.

func _on_rune_2_pressed() -> void:
	PlayerData1.currency -= available[1][2]
	print("pruchased " + available[1][0])
	print("currency: "+ str(PlayerData1.currency))
	pass # Replace with function body.


func _on_rune_3_pressed() -> void:
	PlayerData1.currency -= available[2][2]
	print("pruchased " + available[2][0])
	print("currency: "+ str(PlayerData1.currency))
	pass # Replace with function body.


func _on_rune_4_pressed() -> void:
	PlayerData1.currency -= available[3][2]
	print("pruchased " + available[3][0])
	print("currency: "+ str(PlayerData1.currency))
	pass # Replace with function body.
