extends Node2D
@export var id = "Berrybushbear"
@export var health = 60
@export var stun = false
@export var infrontplayer = false
@export var squarepos = 0
@export var power = 10
var underground
var undergroundcount
var maxhealth = 60
var round = 0.5
var rng = RandomNumberGenerator.new()

var anim
var vfx
var pointer
@onready var healthbar =$Healthbar

func _ready():
	anim = $AnimatedSprite2D
	vfx = $VFX
	pointer = $pointer
	underground = false
	undergroundcount = 0
	healthbar.init_health(health)

func on_attack():
	if underground != true: 
		$AnimatedSprite2D.play("Attack")
		return(power)
	else:
		return(0)
	
#plays the hurt animation and applies the damage
func on_hurt(damage: int, spell:String):
	vfx.play(spell)
	if underground == false:
		health = health-damage
	else:
		health = health - damage/2
	healthbar.set_health(health)
#Destroys the node should have an animation
func death():
	queue_free()
	
#Behaviour for each turn
func turn():
	if stun == true && underground == false:
		stun = false
	if health < (maxhealth*0.8) && underground == false:
		var rngvalue = rng.randi_range(1,3)
		print(rngvalue)
		if rngvalue == 1:
			dig()
	if underground == true:
		undergroundcount = undergroundcount-1
		match undergroundcount:
			1:heal()
			0:anim.play("Rest");underground=false
		
func _on_vfx_animation_finished() -> void:
	if underground == false:
		anim.play("Hurt")
	else:
		anim.play("HurtUnderground")
	if health <= 0:
		stun = true
		await get_tree().create_timer(round).timeout
		death()
		

func on_first():
	pointer.play("pointer")

func dig():
	if underground != true:
		underground = true
		undergroundcount = 3
		anim.play("Dig")

func heal():
	var healvalue = rng.randi_range(5, 20)
	anim.play("Sleep")
	health = health + healvalue
	if health > maxhealth : health = maxhealth
	healthbar.set_health(health)
