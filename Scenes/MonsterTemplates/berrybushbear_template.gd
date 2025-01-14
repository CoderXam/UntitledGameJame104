extends Node2D
@export var id = "Berrybushbear"
@export var health = 25
@export var stun = false
@export var infrontplayer = false
@export var squarepos = 0
@export var power = 10
@export var underground = false
var maxhealth = 25

func on_attack():
	$AnimatedSprite2D.play("Attack")
	return(power)
	
#plays the hurt animation and applies the damage
func on_hurt(damage):
	$AnimatedSprite2D.play("Hurt")
	health = health-damage
	return(health)
	
#Destroys the node should have an animation
func death():
	queue_free()
	
#Behaviour for each turn
func turn():
	if stun == true:
		stun = false
