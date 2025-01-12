extends Node2D
	
# positions in array:
# 0 = name, 1 = description, 2 = price, 3 = probability of showing up in shop, 4 = amount in stock
var shop_inv = {"Fire": ["Fireball","Launch a scorching fireball attack", 5, 10, 0],
 				"Magma" : ["Magma","Turn the ground to molten rock", 5, 10, 0],
			 	"Water" : ["Water Blast","Blast foes back and deal damage with a pressurized beam of water", 5, 10, 0],
				"Shield" : ["Shield","Block incoming attacks with an arcane ward", 5, 10, 0],
			 	"Orb" : ["Orb","Pierce through enemies with a spectral orb", 5, 10, 0],
				"Lifesteal" : ["Lifesteal","Sap away the lifeforce of enemies for yourself", 5, 10, 0], 
				"Root" : ["Root Snatch","Fix enemies in place with grasping roots", 5, 10, 0],
				"Lightning" : ["Lightning Bolt","Shock and stun enemies with a bolt of lightning", 5, 10, 0], 
				"Amplify" : ["Amplify","Amplify other runes", 5, 10, 0], 
				"Thorn" : ["Thorn Needles","Riddle your enemies with thorny needles", 5, 10, 0]}
# Called when the node enters the scene tree for the first time.

var pool = [shop_inv["Fire"],shop_inv["Magma"],shop_inv["Water"],shop_inv["Shield"],shop_inv["Orb"],shop_inv["Lifesteal"],shop_inv["Root"],shop_inv["Lightning"],shop_inv["Amplify"],shop_inv["Thorn"],]
var available = []
var randnum = 0
var names = []
var desc = []
var stock_text = []
var stock = [0,0,0,0]

func _ready() -> void:
	names = [$rune1/name,$rune2/name,$rune3/name,$rune4/name]
	desc = [$rune1/description,$rune2/description,$rune3/description,$rune4/description]
	stock_text = [$rune1/stock,$rune2/stock,$rune3/stock,$rune4/stock]
	
	for i in 4: # Generate rune for each slot in the shop
		randnum = randi_range(1,100)
		for j in 10:
			# If random number is between 1-10, choose the 1st spell
			# If randum number is between 2-20 choose the 2nd spell
			# etc. (This only works since probabilities are equally distributed)
			if randnum > j*10 and randnum < (j+1)*10+1:
				available.append(pool[j])
				stock[i] = 2
		
		#print(str(i+1)+". "+available[i][0])
		names[i].text = available[i][0]
		desc[i].text = available[i][1]
		stock_text[i].text = str(stock[i]) +" in stock"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Balance.text = "You have " + str(PlayerData1.currency) + " moneys"
	$Inventory.text = "Inventory: \n"+str(PlayerData1.inventory)

func _on_rune_1_pressed() -> void:
	var rune = available[0]
	if PlayerData1.currency >= rune[2] and stock[0] > 0:
		# BUY RUNE
		$Shopkeeper/Welcome.text = "Great choice!"
		PlayerData1.currency -= rune[2]
		PlayerData1.add_to_inventory(rune)
		stock[0] -= 1
		if stock[0] > 0:
			stock_text[0].text = str(stock[0]) +" in stock"
		else:
			stock_text[0].text = "out of stock"
		
		print("pruchased " + rune[0])
		# BUY FAILED
	elif stock[0] == 0:
		$Shopkeeper/Welcome.text = "Sorry pal, none left"
	elif PlayerData1.currency < rune[2]:
		$Shopkeeper/Welcome.text = "Nothing in life is free"

func _on_rune_2_pressed() -> void:
	var rune = available[1]
	if PlayerData1.currency >= rune[2] and stock[1] > 0:
		# BUY RUNE
		$Shopkeeper/Welcome.text = "Great choice!"
		PlayerData1.currency -= rune[2]
		PlayerData1.add_to_inventory(rune)
		stock[1] -= 1
		if stock[1] > 0:
			stock_text[1].text = str(stock[1]) +" in stock"
		else:
			stock_text[1].text = "out of stock"
		
		print("pruchased " + rune[0])
	# BUY FAILED
	elif stock[1] == 0:
		$Shopkeeper/Welcome.text = "Sorry pal, none left"
	elif PlayerData1.currency < rune[2]:
		$Shopkeeper/Welcome.text = "Nothing in life is free"

func _on_rune_3_pressed() -> void:
	var rune = available[2]
	if PlayerData1.currency >= rune[2] and stock[2] > 0:
		# BUY RUNE
		$Shopkeeper/Welcome.text = "Great choice!"
		PlayerData1.currency -= rune[2]
		PlayerData1.add_to_inventory(rune)
		stock[2] -= 1
		if stock[2] > 0:
			stock_text[2].text = str(stock[2]) +" in stock"
		else:
			stock_text[2].text = "out of stock"
		
		print("pruchased " + rune[0])
	# BUY FAILED
	elif stock[2] == 0:
		$Shopkeeper/Welcome.text = "Sorry pal, none left"
	elif PlayerData1.currency < rune[2]:
		$Shopkeeper/Welcome.text = "Nothing in life is free"

func _on_rune_4_pressed() -> void:
	var rune = available[3]
	if PlayerData1.currency >= rune[2] and stock[3] > 0:
		# BUY RUNE
		$Shopkeeper/Welcome.text = "Great choice!"
		PlayerData1.currency -= rune[2]
		PlayerData1.add_to_inventory(rune)
		stock[3] -= 1
		if stock[3] > 0:
			stock_text[3].text = str(stock[3]) +" in stock"
		else:
			stock_text[3].text = "out of stock"
		
		print("pruchased " + rune[0])
	# BUY FAILED
	elif stock[3] == 0:
		$Shopkeeper/Welcome.text = "Sorry pal, none left"
	elif PlayerData1.currency < rune[2]:
		$Shopkeeper/Welcome.text = "Nothing in life is free"
