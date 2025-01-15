extends Node2D

var mouseHover = false

@onready var spotList = get_parent().get_children()
var spotNum
var runeNum
var isCasting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.hide()
	
	"""
	MAKE SURE THAT THE PARENTS OF THE INSTANCES IN THE CASTING AREA 
	ARE NAMED 'CASTING AREA', OR ELSE EVERYTHING WILL BREAK --JACOB
	"""
	#lets the instance know if it is in the casting area
	if get_parent().name == "Casting Area":
		isCasting = true
		
		for i in range(len(spotList)):
			if $"." == spotList[i]:
				spotNum = i
				Global.spotArr[i]=global_position
				break
		#print(spotNum, ": ", $".")
		if len(PlayerData1.inventory) > spotNum:
			print(PlayerData1.inventory[spotNum].rune_name)
	elif get_parent().name == "Inventory":
		isCasting = false
		for i in range(len(spotList)):
			if $"." == spotList[i]:
				runeNum = i
				Global.runeArr[i]=global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#will turn on if a rune is clicked, will turn off if nothing is clicked
	$ColorRect.visible = Global.hasSelection
	
	#just testing stuff
	#if Input.is_action_just_pressed("ui_accept"):
		#Global.isClicked = not Global.isClicked
	
	
	if Input.is_action_just_pressed("click") and mouseHover == true:
		if Global.hasSelection == true:
			Global.newRunePos = global_position
			#print(global_position, $".")


#func _on_area_2d_mouse_entered():
	#mouseHover = true
	#print(mouseHover, $".")
	#
#
#func _on_area_2d_mouse_exited():
	#mouseHover = false


func _on_color_rect_mouse_entered():
	mouseHover = true


func _on_color_rect_mouse_exited():
	mouseHover = false
