extends Node2D
var tile_effect
var tile_effect_count 
var groundtilesprite
var magmatilesprite 
var combatscene
var damage
var tilesprite 
var tilepos

signal groundeffect(_damage, _pos)
signal tileresponse

func _ready():
	tile_effect = false
	tile_effect_count = 0
	groundtilesprite = preload("res://Sprites/tiles/groundtile1.png")
	magmatilesprite = preload("res://Sprites/tiles/magmatile.png")
	damage = 0
	tilesprite = $Sprite2D
	

func on_tilecheck():
	if tile_effect == true:
		tile_effect_count = tile_effect_count-1
		groundeffect.emit(damage, tilepos)
		if tile_effect_count == 0:
			tile_effect = false 
			tilesprite.texture = groundtilesprite
	tileresponse.emit()

func on_tilechange(_damage,_pos):
	if _pos == tilepos:
		damage = _damage
		tile_effect = true
		tile_effect_count = 2
		tilesprite.texture = magmatilesprite
	
func combatsceneconnect(_combatscene):
	combatscene = _combatscene
	combatscene.tilecheck.connect(on_tilecheck)
	combatscene.tilechange.connect(on_tilechange)
