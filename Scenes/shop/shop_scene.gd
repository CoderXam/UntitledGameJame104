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
"MOVED TO GlobalStuff.gd"

var shop_inv = Global.RUNE_POOL # List of all runes
var available = [] # The runes available in the shop
var randnum = 0
@onready var names = [$rune1/name,$rune2/name,$rune3/name,$rune4/name] # Rune name GUI element
@onready var desc = [$rune1/description,$rune2/description,$rune3/description,$rune4/description] # Rune description GUI element
@onready var stock_text = [$rune1/stock,$rune2/stock,$rune3/stock,$rune4/stock] # Rune stock GUI element
var stock = [0,0,0,0] # Amount of runes in stock for each rune in the shop
@onready var buttons = [$rune1/buy,$rune2/buy,$rune3/buy,$rune4/buy] # Cost GUI element
@onready var images = [$rune1, $rune2, $rune3, $rune4] # Rune images in the shop

var inv_list := "Inventory: \n"
@onready var inv_slots = [$Node2D/Inv1, $Node2D/Inv2, $Node2D/Inv3, $Node2D/Inv4, $Node2D/Inv5, $Node2D/Inv6, $Node2D/Inv7, $Node2D/Inv8, $Node2D/Inv9] # Rune images in the inventory

var hue = 0 # as in color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Check if chances add to 100 (the game will still run but probabilities will be messed up)
	var total = 0
	for i in shop_inv:
		i.in_shop = 0
		total += i.shop_chance
	if total != 100:
		print("WARNING: Rune shop chances do not add to 100!"+" (total="+str(total)+")")
	
	PlayerData1.currency = 100
	
	for i in 4: # Generate the rune for each of the 4 slots in the shop based on shop chance (the probability for a rune to appear in the shop)
		choose_rune()
		stock[i] = 3 # SET THE NUMBER OF RUNES IN STOCK FOR ALL RUNES
		#print(str(i+1)+". "+available[i][0])
		names[i].text = available[i].rune_name
		desc[i].text = available[i].description
		stock_text[i].text = str(stock[i]) +" in stock"
		stock_text[i].add_theme_color_override("default_color", Color(1,1,1,1))
		buttons[i].text = "Buy \n ("+str(available[i].price)+" moneys)"
		images[i].texture = available[i].image
		
	refresh_inventory()

func choose_rune():
	'''This for loop is a little goofy, uncomment the print statements to see what the code is doing. -Max'''
	randnum = randi_range(1,100)
	#print("generated number: "+str(randnum))
	var a = 0
	for j in 10: # Go through the list of runes and choose 1 based on Rune.shop_chance
		#print(str(a)+"-"+str(a+shop_inv[j].shop_chance))
		if randnum > a and randnum <= a+shop_inv[j].shop_chance and shop_inv[j].in_shop == 0:
			#print("found match: "+shop_inv[j].rune_name)
			available.append(shop_inv[j]) # make the rune available in the shop
			shop_inv[j].in_shop = 1 # prevents duplicates
			#print("added "+shop_inv[j].rune_name)
		elif randnum > a and randnum <= a+shop_inv[j].shop_chance and shop_inv[j].in_shop > 0:
			print(shop_inv[j].rune_name+" is already in the shop -> prevented duplicate")
			choose_rune()
			break
		a += shop_inv[j].shop_chance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Balance.text = "You have \n" + str(PlayerData1.currency) + " moneys"
	
	for i in names:
		i.add_theme_color_override("default_color", Color.from_hsv(hue,1,1,1))
	hue += 0.25*delta

# Displays list of items in inventory
func refresh_inventory() -> void:
	for i in inv_slots:
		i.hide()
	inv_list = "Inventory: \n"
	for i in len(PlayerData1.inventory):
		inv_list += "- " + PlayerData1.inventory[i].rune_name + "\n"
		inv_slots[i].texture = PlayerData1.inventory[i].image
		inv_slots[i].scale = Vector2(1,1) # THIS IS TO ADJUST THE NEW IMAGE SCALE FOR THE RUNES
		inv_slots[i].show()
	$Inventory.text = inv_list

func button_pressed(x:int) -> void:
	var rune = available[x]
	
	# Check if money >= rune price AND if in rune is in stock AND if inventory is not full
	if PlayerData1.currency >= rune.price and stock[x] > 0 and PlayerData1.inventory.size() < PlayerData1.capacity:
		# BUY RUNE
		$Shopkeeper/Welcome.text = "Great choice!"
		PlayerData1.currency -= rune.price
		PlayerData1.add_to_inventory(rune)
		refresh_inventory()
		stock[x] -= 1
		if stock[x] > 0: # If still in stock
			stock_text[x].text = str(stock[x]) +" in stock"
		else:
			stock_text[x].text = "out of stock"
			stock_text[x].add_theme_color_override("default_color", Color(1,0,0,1))
		print("pruchased " + rune.rune_name)
	
	elif stock[x] == 0: # If out of stock
		# BUY FAILED
		$Shopkeeper/Welcome.text = "Sorry pal, none left"
	elif PlayerData1.currency < rune.price: # If not enough money
		# BUY FAILED
		$Shopkeeper/Welcome.text = "Nothing in life is free"
	elif PlayerData1.inventory.size() == PlayerData1.capacity: # If inventory full
		$Shopkeeper/Welcome.text = "How you gonna carry that?"

func _on_rune_1_pressed() -> void:
	button_pressed(0)

func _on_rune_2_pressed() -> void:
	button_pressed(1)

func _on_rune_3_pressed() -> void:
	button_pressed(2)

func _on_rune_4_pressed() -> void:
	button_pressed(3)
