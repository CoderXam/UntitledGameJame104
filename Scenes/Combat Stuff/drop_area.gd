extends StaticBody2D


func _ready():
	modulate = Color(Color.ORANGE, 0.7)

func _process(delta):
	if Global.is_dragging:
		visible = true
	else: 
		visible = false
