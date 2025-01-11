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
func _ready() -> void:
	print(shop_inv["Fire"][1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_rune_1_pressed() -> void:
	print("pruchased " + shop_inv["Fire"][0])
	pass # Replace with function body.

func _on_rune_2_pressed() -> void:
	print("pruchased " + shop_inv["Magma"][0])
	pass # Replace with function body.


func _on_rune_3_pressed() -> void:
	print("pruchased " + shop_inv["Water"][0])
	pass # Replace with function body.


func _on_rune_4_pressed() -> void:
	print("pruchased " + shop_inv["Shield"][0])
	pass # Replace with function body.
