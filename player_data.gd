extends Node

@export var max_health = 10
@export var player_health = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hello Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
@export var currency = 20

var inventory: Array = []
@export var starting_item: Item

func add_to_inventory(item) -> void:
	inventory.append(item)
	
func _input(event):
	if event.is_action_pressed("use"):
		starting_item.use()
