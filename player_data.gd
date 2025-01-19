extends Node

@export var max_health = 10
@export var player_health = 10

@export var currency = 10

var inventory: Array = []
var rune_pool: Array = []
var capacity = 9 # Max amount of items in inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hello Player")
	add_to_inventory(Global.orb)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func add_to_inventory(item) -> void:
	inventory.append(item)

#func _input(event):
	#if event.is_action_pressed("use"):
		#starting_rune.use()
