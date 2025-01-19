extends Node2D

var mouseHover = false
var selected = false

@onready var runeList = get_parent().get_children()
var runeNum
var isInInv = true # Is the rune in the casting area?
var isNewSpotTaken = false # bit on the nose, but does what it says

var rune_spell # The spell (instance of rune) associated with this node

func _ready():
	for i in len(runeList):
		if $"." == runeList[i]:
			runeNum = i
			break
	
	if len(PlayerData1.rune_pool) > runeNum:
		rune_spell=PlayerData1.rune_pool[runeNum]
	else:
		rune_spell=Global.EMPTY
	
	#puts the instance of the rune into a dictionary that describes
	#where are the runes are
	Global.runeDict["Inv"][runeNum] = rune_spell


func _process(delta):
	if Input.is_action_just_pressed("click") and mouseHover == true:
		if rune_spell!=Global.EMPTY:
			#locks out other runes from doing anything if another is already selected,
			#but lets the selected rune still unselect itself
			if selected == true or Global.hasSelection == false:
				#lets the rune know that it is selected
				selected = not selected
				#lets other runes know that they cant get selected
				Global.hasSelection = selected
				#debugging purposes to see which rune spot got clicked
				#print(selected, $".")
	
	#this is once it gets told where to go
	if selected == true and Global.newRunePos:
		Global.oldRunePos = position
		#removes itself from where it was in the rune dictionary
		if isInInv:
			Global.runeDict["Inv"][runeNum] = Global.EMPTY
		elif isInInv == false:
			Global.runeDict["Cast"][runeNum] = Global.EMPTY
			Global.attack[runeNum] = Global.EMPTY
		
		for i in 9:
			#will find out where it is moving
			if Global.newRunePos == Global.runeArr[i]:
				runeNum = i
				#updates rune dictionary
				Global.runeDict["Inv"][runeNum] = rune_spell
				if isInInv == false:
					isInInv = true
					PlayerData1.rune_pool.append(rune_spell)
					print("added ",rune_spell.rune_name," back to pool")
				#print(rune_spell.rune_name, " moved to inventory slot ",i+1," from ",Global.oldRunePos," to ", Global.newRunePos)
			if Global.newRunePos == Global.spotArr[i]:
				#mostly the same as above
				runeNum = i
				Global.runeDict["Cast"][runeNum] = rune_spell
				if isInInv == true:
					isInInv = false
					for j in len(PlayerData1.rune_pool):
						if PlayerData1.rune_pool[j]==rune_spell:
							PlayerData1.rune_pool.pop_at(j)
							print("removed ",rune_spell.rune_name," from pool")
							break
				#lets it know what attacks are "cast"
				Global.attack[i] = rune_spell
				#print(rune_spell.rune_name, " moved to casting slot ",i+1," from ",Global.oldRunePos," to ", Global.newRunePos)
		
		#for i in 9:
			#if Global.runeDict["Inv"][i]!=Global.EMPTY:
				#PlayerData1.rune_pool.append(Global.runeDict["Inv"][i])
		
		#actually moves the rune
		var tweenMove = create_tween()
		tweenMove.tween_property(self, "global_position", Global.newRunePos, 0.1)
		
		#resetting everything so that a new rune can be selected
	
		isNewSpotTaken = false
		selected = false
		Global.hasSelection = false
		Global.newRunePos = null
	
	
	#press down to look through the dubuger :)
	if Input.is_action_just_pressed("ui_down"):
		pass



func _on_area_2d_mouse_entered():
	mouseHover = true
	

func _on_area_2d_mouse_exited():
	mouseHover = false
	
