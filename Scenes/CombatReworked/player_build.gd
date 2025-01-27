extends Node2D
var health = 30
var totalhealth = 30
var shielded = 0
var anim
var shield
var vfx
var healthbar 

signal hurtfinished()


func _ready() -> void:
	anim = $AnimatedSprite2D
	shield = $shield
	vfx = $VFX
	healthbar = $Healthbar
	healthbar.init_health(totalhealth)
	healthbar.health = health
	anim.play("Bob_Idle")

func hurt(damage: int):
	if shielded == 0 && damage != 0:
		health = health - damage
		healthbar.set_health(health)
		anim.play("Hurt")
		await anim.animation_finished
		hurtfinished.emit()
	elif shielded:
		shield.play("shieldblock")
		await shield.animation_finished()
		hurtfinished.emit()
		
	
func on_heal(heal: int):
	health = health + heal
	if health > totalhealth: 
		health = totalhealth
	healthbar.set_health(health)
func on_shield():
	shielded = 1 # Amount of hits shield can take
	shield.play("shield")
	
func deshield():
	shielded = 0
	shield.play("default")


func _on_animated_sprite_2d_animation_finished() -> void:
	anim.play("Bob_Idle")
	
func lightball(damage: int):
	vfx.play("lightball")
	await vfx.animation_finished
	hurt(damage)
