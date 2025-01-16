extends Node2D

var mouseHover = false
var selected = false

@onready var runeList = get_parent().get_children()
var runeNum

var rune_spell # The spell (instance of rune) associated with this node

func _ready():
	for i in range(len(runeList)):
		if $"." == runeList[i]:
			runeNum = i
			break
	
	if len(PlayerData1.inventory) > runeNum:
		rune_spell=PlayerData1.inventory[runeNum]
	else:
		rune_spell=Global.EMPTY
	
	print("Inventory ",runeNum+1, ": ", rune_spell.rune_name)


func _process(delta):
	if Input.is_action_just_pressed("click") and mouseHover == true:
		if rune_spell.rune_name != "empty":
			#locks out other runes from doing anything if another is already selected,
			#but lets the selected rune still unselect itself
			if selected == true or Global.hasSelection == false:
				#lets the rune know that it is selected
				selected = not selected
				#lets other runes know that they cant get selected
				Global.hasSelection = selected
				#debugging purposes to see which rune spot got clicked
				#print(selected, $".")
	
	if selected == true and Global.newRunePos:
		#put actually useful code here
		var tweenMove = create_tween()
		tweenMove.tween_property(self, "position", Global.newRunePos + Vector2(24,24), 0.1)
		
		for i in 9:
			if Global.newRunePos == Global.runeArr[i]:
				print(rune_spell.rune_name, " moved to inventory slot ",i+1," at ",Global.newRunePos)
			if Global.newRunePos == Global.spotArr[i]:
				print(rune_spell.rune_name, " moved to casting slot ",i+1," at ",Global.newRunePos)
		
		#resetting everything so that a new rune can be selected
		selected = false
		Global.hasSelection = false
		Global.newRunePos = null
	



func _on_area_2d_mouse_entered():
	mouseHover = true
	

func _on_area_2d_mouse_exited():
	mouseHover = false
	
