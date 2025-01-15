extends Node2D
@export var health = 30
var anim

func _ready() -> void:
	anim = $AnimatedSprite2D
	pass # Replace with function body.

func hurt(damage):
	health = health - damage
	anim.play("Hurt")
