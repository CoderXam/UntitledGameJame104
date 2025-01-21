extends Node2D


var enemytiles
var enemytilesresponsecount = 0
var enemyspaces

signal tilecheck
signal tilechange(_damage, _pos)
signal tileresponseconfirmed

func _ready():
	##tile get & connection
	enemytiles = $enemytiles.get_children()
	tileconnect()
	##enemyspace array generation
	enemyspaces = $enemyspaces.get_children()

func on_groundeffect(_damage, _pos):
	print("damage dealt = "+ str(_damage) + " at location " + str(_pos))

func tileconnect():
	for i in range(enemytiles.size()):
		enemytiles[i].tilepos = i+1
		enemytiles[i].groundeffect.connect(on_groundeffect)
		enemytiles[i].combatsceneconnect(self)

func on_tileresponse():
	if enemytilesresponsecount != enemytiles.size():
		enemytilesresponsecount = enemytilesresponsecount + 1
	else:
		enemytilesresponsecount = 0
		tileresponseconfirmed.emit()
		
