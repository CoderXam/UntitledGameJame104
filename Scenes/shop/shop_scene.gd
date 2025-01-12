extends Node2D

'''Old code using dictionary'''
# positions in array:
# 0 = name, 1 = description, 2 = price, 3 = probability of showing up in shop (out of 100)
#var shop_inv = {"Fire": ["Fireball","Launch a scorching fireball attack", 5, 10],
 				#"Magma" : ["Magma","Turn the ground to molten rock", 5, 10],
			 	#"Water" : ["Water Blast","Blast foes back and deal damage with a pressurized beam of water", 5, 10],
				#"Shield" : ["Shield","Block incoming attacks with an arcane ward", 5, 10],
			 	#"Orb" : ["Orb","Pierce through enemies with a spectral orb", 5, 10],
				#"Lifesteal" : ["Lifesteal","Sap away the lifeforce of enemies for yourself", 5, 10], 
				#"Root" : ["Root Snatch","Fix enemies in place with grasping roots", 5, 10],
				#"Lightning" : ["Lightning Bolt","Shock and stun enemies with a bolt of lightning", 5, 10], 
				#"Amplify" : ["Amplify","Amplify other runes", 5, 10], 
				#"Thorn" : ["Thorn Needles","Riddle your enemies with thorny needles", 5, 10]}

'''New code using Rune class'''
var fire := Rune.new("Fireball","Launch a scorching fireball attack")
var magma := Rune.new("Magma Stomp","Turn the ground to molten rock")
var water := Rune.new("Water Blast","Blast foes back and deal damage with a pressurized beam of water")
var shield := Rune.new("Shield","Block incoming attacks with an arcane ward")
var orb := Rune.new("Orb","Pierce through enemies with a spectral orb")
var lifesteal := Rune.new("Lifesteal","Sap away the lifeforce of enemies for yourself")
var root := Rune.new("Root Snatch","Fix enemies in place with grasping roots")
var lightning := Rune.new("Lightning Bolt","Shock and stun enemies with a bolt of lightning")
var amplify := Rune.new("Amplify","Amplify other runes")
var thorns := Rune.new("Thorn Needles","Riddle your enemies with thorny needles")

var shop_inv = [fire,magma,water,shield,orb,lifesteal,root,lightning,amplify,thorns] # List of all runes
var available = [] # The runes available in the shop
var randnum = 0
var names = [] # Rune name GUI element
var desc = [] # Rune description GUI element
var stock_text = [] # Rune stock GUI element
var stock = [0,0,0,0] # Amount of runes in stock for each rune in the shop
var buttons = [] # Cost GUI element

var inv_list := "Inventory: \n"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	names = [$rune1/name,$rune2/name,$rune3/name,$rune4/name]
	desc = [$rune1/description,$rune2/description,$rune3/description,$rune4/description]
	stock_text = [$rune1/stock,$rune2/stock,$rune3/stock,$rune4/stock]
	buttons = [$rune1/buy,$rune2/buy,$rune3/buy,$rune4/buy,]
	
	for i in 4: # Generate the rune for each of the 4 slots in the shop
		randnum = randi_range(1,100)
		for j in 10: # Go through the list of runes and choose 1
			# If random number is between 1-10, choose the 1st spell,
			# If randum number is between 11-20 choose the 2nd spell, etc.
			# (This only works since probabilities are equally distributed)
			if randnum > j*10 and randnum < (j+1)*10+1:
				available.append(shop_inv[j])
				stock[i] = 2 # Set the number of runes in stock for all runes
		
		#print(str(i+1)+". "+available[i][0])
		names[i].text = available[i].rune_name
		desc[i].text = available[i].description
		stock_text[i].text = str(stock[i]) +" in stock"
		buttons[i].text = "Buy \n ("+str(available[i].price)+" moneys)"
		
	refresh_inventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Balance.text = "You have " + str(PlayerData1.currency) + " moneys"

# Displays list of items in inventory
func refresh_inventory() -> void:
	inv_list = "Inventory: \n"
	for i in PlayerData1.inventory:
		inv_list += "- " + i.rune_name + "\n"
	$Inventory.text = inv_list
	pass
#-----------------------------------------------------------------------------------------------------------
# BUTTONS
#-----------------------------------------------------------------------------------------------------------
# Under here are 4 functions that do the same thing, there is 1 for each rune in the shop
# I used signals to detect when a button is pressed so I had to make a seperate function for each signal
# If someone can figure out a better way to did (i.e. to avoid 4 copies of the same function) pls fix it
# - Max

func _on_rune_1_pressed() -> void:
	var rune = available[0]
	if PlayerData1.currency >= rune.price and stock[0] > 0: # Check if money >= rune price and if in stock
		# BUY RUNE
		$Shopkeeper/Welcome.text = "Great choice!"
		PlayerData1.currency -= rune.price
		PlayerData1.add_to_inventory(rune)
		refresh_inventory()
		stock[0] -= 1
		if stock[0] > 0: # If still in stock
			stock_text[0].text = str(stock[0]) +" in stock"
		else:
			stock_text[0].text = "out of stock"
		print("pruchased " + rune.rune_name)
	
	elif stock[0] == 0: # If out of stock
		# BUY FAILED
		$Shopkeeper/Welcome.text = "Sorry pal, none left"
	elif PlayerData1.currency < rune.price: # If not enough money
		# BUY FAILED
		$Shopkeeper/Welcome.text = "Nothing in life is free"

func _on_rune_2_pressed() -> void:
	var rune = available[1]
	if PlayerData1.currency >= rune.price and stock[1] > 0: # Check if money >= rune price and if in stock
		# BUY RUNE
		$Shopkeeper/Welcome.text = "Great choice!"
		PlayerData1.currency -= rune.price
		PlayerData1.add_to_inventory(rune)
		refresh_inventory()
		stock[1] -= 1
		if stock[1] > 0: # If still in stock
			stock_text[1].text = str(stock[1]) +" in stock"
		else:
			stock_text[1].text = "out of stock"
		print("pruchased " + rune.rune_name)
	
	elif stock[1] == 0: # If out of stock
		# BUY FAILED
		$Shopkeeper/Welcome.text = "Sorry pal, none left"
	elif PlayerData1.currency < rune.price: # If not enough money
		# BUY FAILED
		$Shopkeeper/Welcome.text = "Nothing in life is free"

func _on_rune_3_pressed() -> void:
	var rune = available[2]
	if PlayerData1.currency >= rune.price and stock[2] > 0: # Check if money >= rune price and if in stock
		# BUY RUNE
		$Shopkeeper/Welcome.text = "Great choice!"
		PlayerData1.currency -= rune.price
		PlayerData1.add_to_inventory(rune)
		refresh_inventory()
		stock[2] -= 1
		if stock[2] > 0: # If still in stock
			stock_text[2].text = str(stock[2]) +" in stock"
		else:
			stock_text[2].text = "out of stock"
		print("pruchased " + rune.rune_name)
	
	elif stock[2] == 0: # If out of stock
		# BUY FAILED
		$Shopkeeper/Welcome.text = "Sorry pal, none left"
	elif PlayerData1.currency < rune.price: # If not enough money
		# BUY FAILED
		$Shopkeeper/Welcome.text = "Nothing in life is free"

func _on_rune_4_pressed() -> void:
	var rune = available[3]
	if PlayerData1.currency >= rune.price and stock[3] > 0: # Check if money >= rune price and if in stock
		# BUY RUNE
		$Shopkeeper/Welcome.text = "Great choice!"
		PlayerData1.currency -= rune.price
		PlayerData1.add_to_inventory(rune)
		refresh_inventory()
		stock[3] -= 1
		if stock[3] > 0: # If still in stock
			stock_text[3].text = str(stock[3]) +" in stock"
		else:
			stock_text[3].text = "out of stock"
		print("pruchased " + rune.rune_name)
	
	elif stock[3] == 0: # If out of stock
		# BUY FAILED
		$Shopkeeper/Welcome.text = "Sorry pal, none left"
	elif PlayerData1.currency < rune.price: # If not enough money
		# BUY FAILED
		$Shopkeeper/Welcome.text = "Nothing in life is free"
