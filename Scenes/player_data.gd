extends Node2D

@export var max_health = 10
@export var player_health = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
var inventory = []
func add_to_inventory(item) -> void:
	inventory.append(item)
