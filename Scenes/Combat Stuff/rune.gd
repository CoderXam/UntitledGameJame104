extends Node2D

var mouseHover = false
var selected = false

func _process(delta):
	if Input.is_action_just_pressed("click") and mouseHover == true:
		#locks out other runes from doing anything if another is already selected,
		#but lets the selected rune still unselect itself
		if selected == true or Global.hasSelection == false:
			#lets the rune know that it is selected
			selected = not selected
			#lets other runes know that they cant get selected
			Global.hasSelection = selected
			#debugging purposes to see which rune spot got clicked
			print(selected, $".")
	
	if selected == true and Global.newRunePos:
		#put actually useful code here
		print($".", " should now appear at ", Global.newRunePos)
		var tweenMove = create_tween()
		tweenMove.tween_property(self, "position", Global.newRunePos + Vector2(24,24), 0.1)
		
		#resetting everything so that a new rune can be selected
		selected = false
		Global.hasSelection = false
		Global.newRunePos = null
	



func _on_area_2d_mouse_entered():
	mouseHover = true
	

func _on_area_2d_mouse_exited():
	mouseHover = false
	
