extends Node2D

var shop_inv = {"Fire": "Launch a scorching fireball attack",
 				"Magma" : "Turn the ground to molten rock",
			 	"Water" : "Blast foes back and deal damage with a pressurized beam of water",
				"Shield" : "Block incoming attacks with an arcane ward",
			 	"Orb" : "Pierce through enemies with a spectral orb", 
				"Lifesteal" : "Sap away the lifeforce of enemies for yourself", 
				"Root" : "Fix enemies in place with grasping roots", 
				"Lightning" : "Shock and stun enemies with a bolt of lightning", 
				"Amplify" : "Amplify other runes", 
				"Thorn" : "Riddle your enemies with thorny needles"}
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
