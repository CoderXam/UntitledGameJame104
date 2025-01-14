extends Node2D
@export var id ="Stonyhedgehog"
@export var health = 30
@export var stun = false
@export var infrontplayer = false
@export var squarepos = 0
@export var power = 5
var maxhealth = 30



#plays the attack animation &  returns the damage
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
