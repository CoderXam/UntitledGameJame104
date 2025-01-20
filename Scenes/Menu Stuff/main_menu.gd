extends Node2D


func _on_start_pressed() -> void:
	Global.level = 1
	get_tree().change_scene_to_file("res://Scenes/shop/shop_scene.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu Stuff/Credits.tscn")

func _on_lore_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu Stuff/lore.tscn")
