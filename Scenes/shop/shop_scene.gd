extends Node2D
	
# positions in array:
# 0 = name, 1 = description, 2 = price, 3 = probability of showing up in shop, 4 = amount in stock
var shop_inv = {"Fire": ["Fireball","Launch a scorching fireball attack", 5, 10, 2],
 				"Magma" : ["Magma","Turn the ground to molten rock", 5, 10, 2],
			 	"Water" : ["Water Blast","Blast foes back and deal damage with a pressurized beam of water", 5, 10, 2],
				"Shield" : ["Shield","Block incoming attacks with an arcane ward", 5, 10, 2],
			 	"Orb" : ["Orb","Pierce through enemies with a spectral orb", 5, 10, 2],
				"Lifesteal" : ["Lifesteal","Sap away the lifeforce of enemies for yourself", 5, 10, 2], 
				"Root" : ["Root Snatch","Fix enemies in place with grasping roots", 5, 10, 2],
				"Lightning" : ["Lightning Bolt","Shock and stun enemies with a bolt of lightning", 5, 10, 2], 
				"Amplify" : ["Amplify","Amplify other runes", 5, 10, 2], 
				"Thorn" : ["Thorn Needles","Riddle your enemies with thorny needles", 5, 10, 2]}
# Called when the node enters the scene tree for the first time.

var pool = [shop_inv["Fire"],shop_inv["Magma"],shop_inv["Water"],shop_inv["Shield"],shop_inv["Orb"],shop_inv["Lifesteal"],shop_inv["Root"],shop_inv["Lightning"],shop_inv["Amplify"],shop_inv["Thorn"],]
var available = []
var randnum = 0
var names = []
var desc = []
var stock = []

func _ready() -> void:
	names = [$rune1/name,$rune2/name,$rune3/name,$rune4/name]
	desc = [$rune1/description,$rune2/description,$rune3/description,$rune4/description]
	stock = [$rune1/stock,$rune2/stock,$rune3/stock,$rune4/stock]
	
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
		stock[i].text = str(available[i][4]) +" in stock"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Balance.text = "You have " + str(PlayerData1.currency) + " moneys"
	

func _on_rune_1_pressed() -> void:
	var rune = available[0]
	if PlayerData1.currency >= rune[2] and rune[4] > 0:
		PlayerData1.currency -= rune[2]
		PlayerData1.add_to_inventory(rune)
		rune[4] -= 1
		if rune[4] > 0:
			stock[0].text = str(rune[4]) +" in stock"
		else:
			stock[0].text = "out of stock"
		
		print("pruchased " + rune[0])
		print(PlayerData1.inventory)
	else:
		print("not enough money or out of stock")

func _on_rune_2_pressed() -> void:
	var rune = available[1]
	if PlayerData1.currency >= rune[2] and rune[4] > 0:
		PlayerData1.currency -= rune[2]
		PlayerData1.add_to_inventory(rune)
		rune[4] -= 1
		if rune[4] > 0:
			stock[1].text = str(rune[4]) +" in stock"
		else:
			stock[1].text = "out of stock"
		
		print("pruchased " + rune[0])
		print(PlayerData1.inventory)
	else:
		print("not enough money or out of stock")


func _on_rune_3_pressed() -> void:
	var rune = available[2]
	if PlayerData1.currency >= rune[2] and rune[4] > 0:
		PlayerData1.currency -= rune[2]
		PlayerData1.add_to_inventory(rune)
		rune[4] -= 1
		if rune[4] > 0:
			stock[2].text = str(rune[4]) +" in stock"
		else:
			stock[2].text = "out of stock"
		
		print("pruchased " + rune[0])
		print(PlayerData1.inventory)
	else:
		print("not enough money or out of stock")


func _on_rune_4_pressed() -> void:
	var rune = available[3]
	if PlayerData1.currency >= rune[2] and rune[4] > 0:
		PlayerData1.currency -= rune[2]
		PlayerData1.add_to_inventory(rune)
		rune[4] -= 1
		if rune[4] > 0:
			stock[3].text = str(rune[4]) +" in stock"
		else:
			stock[3].text = "out of stock"
		
		print("pruchased " + rune[0])
		print(PlayerData1.inventory)
	else:
		print("not enough money or out of stock")
