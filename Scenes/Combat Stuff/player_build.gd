extends Node2D
@export var health = 30
@export var totalhealth = 30
@export var shielded = false
var anim

func _ready() -> void:
	anim = $AnimatedSprite2D
	pass # Replace with function body.

func hurt(damage: int):
	if shielded != true:
		health = health - damage
		anim.play("Hurt")

func on_heal(heal: int):
	health = health + heal
	if health > totalhealth: 
		health = totalhealth
		
func on_shield():
	shielded = true
