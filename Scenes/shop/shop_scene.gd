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

var available = []
var randnum = 0

func _ready() -> void:
	for i in 4:
		randnum = randi_range(1,100)
		if randnum > 0 and randnum < 11:
			available.append(shop_inv["Fire"])
		elif randnum > 10 and randnum < 21:
			available.append(shop_inv["Magma"])
		elif randnum > 20 and randnum < 31:
			available.append(shop_inv["Water"])
		elif randnum > 30 and randnum < 41:
			available.append(shop_inv["Shield"])
		elif randnum > 40 and randnum < 51:
			available.append(shop_inv["Orb"])
		elif randnum > 50 and randnum < 61:
			available.append(shop_inv["Lifesteal"])
		elif randnum > 60 and randnum < 71:
			available.append(shop_inv["Root"])
		elif randnum > 70 and randnum < 81:
			available.append(shop_inv["Lightning"])
		elif randnum > 80 and randnum < 91:
			available.append(shop_inv["Amplify"])
		elif randnum > 90 and randnum < 101:
			available.append(shop_inv["Thorn"])
		else:
			print("how")
	print(available)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_rune_1_pressed() -> void:
	print("pruchased " + available[0][0])
	pass # Replace with function body.

func _on_rune_2_pressed() -> void:
	print("pruchased " + available[1][0])
	pass # Replace with function body.


func _on_rune_3_pressed() -> void:
	print("pruchased " + available[2][0])
	pass # Replace with function body.


func _on_rune_4_pressed() -> void:
	print("pruchased " + available[3][0])
	pass # Replace with function body.
