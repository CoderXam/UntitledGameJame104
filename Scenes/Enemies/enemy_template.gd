extends Node2D

@export var health = 10
const tileSize = Global.tileSize
var moving = false
var direction = Vector2(-1,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	#print("loaded")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		move()
	pass



func move():
	if moving == false:
		moving = true
		var tweenMove = create_tween()
		#print("tween begin")
		tweenMove.tween_property(self, "position", position + tileSize * direction, 0.1)
		tweenMove.tween_callback(move_false)

func move_false():
	#print("tween end")
	moving = false
