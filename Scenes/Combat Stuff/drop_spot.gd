extends Node2D

var mouseHover = false



# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.hide()


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
			print(global_position, $".")


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
