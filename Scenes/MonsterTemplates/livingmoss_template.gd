extends Node2D
var health = 15
var stun = false
var infrontplayer = false
var squarepos = 0
var power = 5

var anim
var vfx
var pointer
@onready var healthbar =$Healthbar

signal hurtfinished()


func _ready():
	anim = $AnimatedSprite2D
	vfx = $VFX
	pointer = $pointer
	healthbar.init_health(health)

#plays the attack animation &  returns the damage
func on_attack():
	anim.play("Attack")
	await anim.animation_finished
	return
	
#plays the hurt animation and applies the damage
func on_hurt(damage: int, spell:String):
	if damage != 0 :
		vfx.play(spell)
		await vfx.animation_finished
		anim.play("Hurt")
		health = health-damage
		healthbar.set_health(health)
		await anim.animation_finished
		hurtfinished.emit()
		if health <= 0:
			stun = true
			death()
	else:
		hurtfinished.emit()
	

#Destroys the node should have an animation
func death():
	stun = true
	queue_free()
	
#Behaviour for each turn
func turn():
	if stun == true:
		stun = false
		


func on_first():
	pointer.play("pointer")
