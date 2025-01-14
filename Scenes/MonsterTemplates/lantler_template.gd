extends Node2D
@export var id = "Lantler"
@export var health = 15
@export var stun = false
@export var infrontplayer = false
@export var squarepos = 0
@export var power = 5
@export var glowlevel = 0
var maxhealth = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
#plays the attack animation &  returns the damage
func on_attack():
	match glowlevel:
		0:$AnimatedSprite2D.play("Attack")
		1:$AnimatedSprite2D.play("AttackG1")
		2:$AnimatedSprite2D.play("AttackG2")
		3:$AnimatedSprite2D.play("AttackG3")
	await $AnimatedSprite2D.animation_finished
	return(power)
	
#plays the hurt animation and applies the damage
func on_hurt(damage):
	match glowlevel:
		0:$AnimatedSprite2D.play("Hurt")
		1:$AnimatedSprite2D.play("HurtG1")
		2:$AnimatedSprite2D.play("HurtG2")
		3:$AnimatedSprite2D.play("HurtG3")
	await $AnimatedSprite2D.animation_finished
	health = health-damage
	return(health)
	
#Destroys the node should have an animation
func death():
	queue_free()
	
#Behaviour for each turn
func turn():
	print("Lantler_turn")
	if stun == true:
		stun = false
	if glowlevel !=3:
		print("Increase glow level")
		glowlevel = glowlevel + 1
		match glowlevel:
			1:$AnimatedSprite2D.play("RestG1")
			2:$AnimatedSprite2D.play("RestG2")
			3:$AnimatedSprite2D.play("RestG3")
	else:
		glowlevel = 0
		$AnimatedSprite2D.play("Rest")

	 
