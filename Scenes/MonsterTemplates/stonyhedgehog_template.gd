extends Node2D
@export var id ="Stonyhedgehog"
@export var health = 30
@export var stun = false
@export var infrontplayer = false
@export var squarepos = 0
@export var power = 5
var maxhealth = 30
var round = 0.5



#plays the attack animation &  returns the damage
func on_attack():
	$AnimatedSprite2D.play("Attack")
	return(power)
	
#plays the hurt animation and applies the damage
func on_hurt(damage):
	$AnimatedSprite2D.play("Hurt")
	health = health-damage
	if health <= 0:
		stun = true
		await get_tree().create_timer(round).timeout
		death()
	
#Destroys the node should have an animation
func death():
	queue_free()
	
#Behaviour for each turn
func turn():
	if stun == true:
		stun = false
