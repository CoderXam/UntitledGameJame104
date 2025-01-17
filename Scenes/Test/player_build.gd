extends Node2D
@export var health = 30
@export var totalhealth = 30
@export var shielded = false
var anim
var shield
var vfx
@onready var healthbar =$Healthbar

func _ready() -> void:
	anim = $AnimatedSprite2D
	shield = $shield
	vfx = $VFX
	healthbar.init_health(totalhealth)
	healthbar.health = health
	anim.play("Bob_Idle")

func hurt(damage: int):
	if shielded != true && damage != 0:
		health = health - damage
		healthbar.set_health(health)
		anim.play("Hurt")
	elif shielded == true:
		shield.play("shieldblock")
	
func on_heal(heal: int):
	health = health + heal
	if health > totalhealth: 
		health = totalhealth
	healthbar.set_health(health)
func on_shield():
	shielded = true
	shield.play("shield")
	
func deshield():
	shielded = false
	shield.play("default")


func _on_animated_sprite_2d_animation_finished() -> void:
	anim.play("Bob_Idle")
	
func lightball(damage: int):
	vfx.play("lightball")
	await vfx.animation_finished
	hurt(damage)
