extends Node2D

#0 pos in array = description, 1 = price, 2 = probability of showing up
var shop_inv = {"Fire": ["Launch a scorching fireball attack", 5, 10],
 				"Magma" : ["Turn the ground to molten rock", 5, 10],
			 	"Water" : ["Blast foes back and deal damage with a pressurized beam of water", 5, 10],
				"Shield" : ["Block incoming attacks with an arcane ward", 5, 10],
			 	"Orb" : ["Pierce through enemies with a spectral orb", 5, 10],
				"Lifesteal" : ["Sap away the lifeforce of enemies for yourself", 5, 10], 
				"Root" : ["Fix enemies in place with grasping roots", 5, 10],
				"Lightning" : ["Shock and stun enemies with a bolt of lightning", 5, 10], 
				"Amplify" : ["Amplify other runes", 5, 10], 
				"Thorn" : ["Riddle your enemies with thorny needles", 5, 10]}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(shop_inv["Fire"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_rune1_pressed() -> void:
	# check if enough currency
	# if no -> error message "not enough currency"
	# if yes -> add to inventory
	print("purchased rune1")
