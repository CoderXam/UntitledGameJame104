extends Node2D
@export var id = "Lantler"
@export var health = 15
@export var stun = false
@export var infrontplayer = false
@export var squarepos = 0
@export var power = 4
@export var glowlevel = 0
var maxhealth = 15
var round = 0.5

var anim
var vfx
var pointer
@onready var healthbar =$Healthbar

signal blast

func _ready():
	anim = $AnimatedSprite2D
	vfx = $VFX
	pointer = $pointer
	anim.animation_finished.connect(_on_anim_finish)
	healthbar.init_health(health)
#plays the attack animation &  returns the damage
func on_attack():
	match glowlevel:
		0:anim.play("Attack")
		1:anim.play("AttackG1")
		2:anim.play("AttackG2")
		3:anim.play("AttackG3")
	return(power)
	
#plays the hurt animation and applies the damage
func on_hurt(damage: int, spell:String):
	vfx.play(spell)
	health = health-damage
	healthbar.set_health(health)
	
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
			1:anim.play("RestG1")
			2:anim.play("RestG2")
			3:anim.play("RestG3")
	else:
		anim.play("blast")
		
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
	

func _on_anim_finish() -> void:
	if anim.animation == "blast":
		glowlevel =0
		blast.emit(power*3)
	
