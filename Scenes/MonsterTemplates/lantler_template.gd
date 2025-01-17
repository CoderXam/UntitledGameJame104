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

var anim
var vfx
var pointer

func _ready():
	anim = $AnimatedSprite2D
	vfx = $VFX
	pointer = $pointer
	
#plays the attack animation &  returns the damage
func on_attack():
	match glowlevel:
		0:$AnimatedSprite2D.play("Attack")
		1:$AnimatedSprite2D.play("AttackG1")
		2:$AnimatedSprite2D.play("AttackG2")
		3:$AnimatedSprite2D.play("AttackG3")
	return(power)
	
#plays the hurt animation and applies the damage
func on_hurt(damage: int, spell:String):
	vfx.play(spell)
	health = health-damage
	
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
func _on_vfx_animation_finished() -> void:
	match glowlevel: 
		0:anim.play("Hurt")
		1:anim.play("HurtG1")
		2:anim.play("HurtG2")
		3:anim.play("HurtG3")
	if health <= 0:
		stun = true
		await get_tree().create_timer(round).timeout
		death()
	 
func on_first():
	pointer.play("pointer")
