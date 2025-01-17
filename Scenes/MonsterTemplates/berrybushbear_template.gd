extends Node2D
@export var id = "Berrybushbear"
@export var health = 25
@export var stun = false
@export var infrontplayer = false
@export var squarepos = 0
@export var power = 10
@export var underground = false
var maxhealth = 25
var round = 0.5

var anim
var vfx
var pointer

func _ready():
	anim = $AnimatedSprite2D
	vfx = $VFX
	pointer = $pointer

func on_attack():
	$AnimatedSprite2D.play("Attack")
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
		
func _on_vfx_animation_finished() -> void:
	anim.play("Hurt")
	if health <= 0:
		stun = true
		await get_tree().create_timer(round).timeout
		death()
		

func on_first():
	pointer.play("pointer")
