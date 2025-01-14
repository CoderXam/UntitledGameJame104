extends Node2D

@export var totalhealth = 10
@export var health = 10

@onready var AnimatedSprite = $AnimatedSprite2D

var CharacterState = Global.CharacterState

var currentState = CharacterState.MOVING

const tileSize = Global.tileSize
var moving = false
var direction = Vector2(-1,0)
var arrPos  

# Called when the node enters the scene tree for the first time.
func _ready():
	var CombatScene = get_node("../")
	#print("loaded")

	#sets position of character in array thingy
	position. y = 54
	arrPos = floor(position.x / 64)
	#print(arrPos)
	position.x = arrPos * 64
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		AnimatedSprite.play("Hurt")





func move():
	if moving == false:
		moving = true
		var tweenMove = create_tween()
		#print("tween begin")
		tweenMove.tween_property(self, "position", position + tileSize * direction, 0.1)
		arrPos += direction.x
		#print(arrPos)
		
		tweenMove.tween_callback(move_false)

func move_false():
	#print("tween end")
	moving = false
	
	#"just for testing to stop one of the enemies"
	#if arrPos == 7:
		#currentState = CharacterState.STUCK

func hurt(damage):
	AnimatedSprite.play("Hurt")
	print("Death Animation Played")
	health-damage
	if health <= 0:
		print("dead")

"""
FOR THIS TO WORK, YOU MUST MANUALLY CONNECT THE roundEnd and roundStart SIGNAL 
TO EACH INSTANCE OF THE MONSTERS CREATED IN THE SCENE. THERE SHOULD BE A LITTLE GREEN ARROW
ON THE LEFT OF THE FUNCTION DECLARATION WHEN VIEWING THE SCRIPT FROM THE DESIRED SCENE

IF NOT SURE HOW/WHAT TO DO FOR THIS, ASK JACOB
SORRY THIS IS INCONVENIENT, BUT I COULDN'T GET IT TO WORK ANY OTHER WAY
"""
func _on_combat_scene_round_end(rounds):
	#print("enenmy round end")
	#print(rounds)
	
	#print(arrPos, " check: ", arrPos- 1, Global.charPositions[arrPos - 1 ] )
	#logic to check if next space is free
	if Global.charPositions[arrPos - 1 ] == CharacterState.MOVING:
		#check if enemy is eligible to move or not
		if currentState == CharacterState.MOVING:
			move()
	else:
		
		if Global.charPositions[arrPos-1] == CharacterState.PLAYER:
			AnimatedSprite.play("Attack")
			print("Attack Animation Played")
		#basically, if this instance is unable to move forward, it puts in the global position
		#array that it is stuck, just for right now, without changing it's currentState
		#not sure how well this will hold up tbh, but it works for now --jacob
		Global.charPositions[arrPos] = CharacterState.STUCK
	
	#print("done moving")
	

func _on_combat_scene_round_start():
	#sets the state of this instance into the global position array
	#allows other enemies to see whether they'll be allowed to move here or not
	Global.charPositions[arrPos] = currentState
