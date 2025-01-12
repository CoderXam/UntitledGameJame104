extends Node

@export var max_health = 10
@export var player_health = 10

@export var currency = 21

var inventory: Array = []
var starting_rune: Rune = Rune.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hello Player")
	starting_rune.name = "magic thing"
	starting_rune.description = "a magical thing"
	add_to_inventory(starting_rune)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func add_to_inventory(item) -> void:
	inventory.append(item)

func _input(event):
	if event.is_action_pressed("use"):
		starting_rune.use()
