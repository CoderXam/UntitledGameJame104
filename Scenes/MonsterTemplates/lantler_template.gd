extends Node2D
@export var id = "Lantler"
@export var health = 15
@export var stun = false
@export var infrontplayer = false
@export var squarepos = 0
@export var power = 5
@export var glowlevel = 0
var maxhealth = 15
var round = 0.5

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
	return(power)
	
#plays the hurt animation and applies the damage
func on_hurt(damage):
	match glowlevel:
		0:$AnimatedSprite2D.play("Hurt")
		1:$AnimatedSprite2D.play("HurtG1")
		2:$AnimatedSprite2D.play("HurtG2")
		3:$AnimatedSprite2D.play("HurtG3")
	health = health-damage
	if health <=0:
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
	if glowlevel !=3:
		glowlevel = glowlevel + 1
		match glowlevel:
			1:$AnimatedSprite2D.play("RestG1")
			2:$AnimatedSprite2D.play("RestG2")
			3:$AnimatedSprite2D.play("RestG3")
	else:
		glowlevel = 0
		$AnimatedSprite2D.play("Rest")

	 
