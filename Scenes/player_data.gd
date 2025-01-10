extends Node2D

@export var MaxHealth = 10
@export var PlayerHealth = 10

var Inventory = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_to_inventory(item) -> void:
	Inventory.append(item)
