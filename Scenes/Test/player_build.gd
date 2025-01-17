extends Node2D
@export var health = 30
@export var totalhealth = 30
@export var shielded = false
var anim
var shield

func _ready() -> void:
	anim = $AnimatedSprite2D
	shield = $shield
	anim.play("Bob_Idle")

func hurt(damage: int):
	if shielded != true:
		health = health - damage
		anim.play("Hurt")
	else:
		shield.play("shieldblock")

func on_heal(heal: int):
	health = health + heal
	if health > totalhealth: 
		health = totalhealth
		
func on_shield():
	shielded = true
	shield.play("shield")
	
func deshield():
	shielded = false
	shield.play("default")


func _on_animated_sprite_2d_animation_finished() -> void:
	anim.play("Bob_Idle")
