extends Node2D


var enemytiles
var enemytilesresponsecount = 0
var enemyspaces
var enemynode
var enemies

signal tilecheck
signal tilechange(_damage, _pos)
signal tileresponseconfirmed

var level
var Livingmoss_load
var Stonyhedgehog_load
var Lantler_load
var Berrybushbear_load
var player
var playerturn = true

signal movementend
signal roundend

func _ready():
	##tile get & connection
	enemytiles = $enemytiles.get_children()
	tileconnect()
	##enemyspace array generation
	enemyspaces = $enemyspaces.get_children()
	##stage building
	level = GameData.stage
	player = $PlayerSpace/PlayerBuild
	enemynode = $enemies
	Livingmoss_load = preload("res://Scenes/MonsterTemplates/Livingmoss_Template.tscn")
	Stonyhedgehog_load = preload("res://Scenes/MonsterTemplates/Stonyhedgehog_Template.tscn")
	Lantler_load = preload("res://Scenes/MonsterTemplates/Lantler_Template.tscn")
	Berrybushbear_load = preload("res://Scenes/MonsterTemplates/Berrybushbear_Template.tscn")
	stagebuilding()
	##button
	

func on_groundeffect(_damage: int, _pos: int):
	var finalcheck = null
	for i in range(enemies.size()):
		if enemies[i].squarepos == _pos:
			enemies[i].on_hurt(_damage, "default")
			finalcheck = i
	if finalcheck !=null:
		await enemies[finalcheck].hurtfinished
	tileresponseconfirmed.emit()

func tileconnect():
	for i in range(enemytiles.size()):
		enemytiles[i].tilepos = i+1
		enemytiles[i].groundeffect.connect(on_groundeffect)
		enemytiles[i].combatsceneconnect(self)

func stagebuilding():
	var stagedict = StageBuilder.stagelayout[level]
	for i in range(enemyspaces.size()):
		match(stagedict[i+1]):
			"Livingmoss":
				var livingmoss = Livingmoss_load.instantiate()
				enemynode.add_child(livingmoss)
				livingmoss.position = enemyspaces[i].position
				livingmoss.squarepos = i+1
				livingmoss.tree_exited.connect(enemydeath)
			"Stonyhedgehog":
				var stonyhedgehog = Stonyhedgehog_load.instantiate()
				enemynode.add_child(stonyhedgehog)
				stonyhedgehog.position = enemyspaces[i].position
				stonyhedgehog.squarepos = i+1
				stonyhedgehog.tree_exited.connect(enemydeath)
			"Lantler":
				pass
			"Berrybushbear":
				pass
	enemies = enemynode.get_children()

func _on_cast_button_pressed() -> void:
	if playerturn == true:
		playerturn = false
		playercast("magma")
		


func playercast(spell : String):
	var spelldict = RuneData.runedictionary[spell]
	var damage = spelldict["damage"]
	if spelldict["knockback"] == true:
		pass
	if spelldict["stun"] == true:
		pass
	if spelldict["shield"] == true:
		pass
	if spelldict["ground"] == true:
		var pos = enemies[0].squarepos
		tilechange.emit(damage,pos)
	enemies[0].on_hurt(damage, spell)
	await enemies[0].hurtfinished
	enemies = enemynode.get_children()
	##enemy movement
	print("Enemy movement")
	enemymovement()
	
func enemymovement():
	var enemymoved = false
	await get_tree().create_timer(0.2).timeout
	if enemies[0].infrontplayer == true && enemies[0].stun == false:
		##enemy attack
		var damage = enemies[0].power
		await enemies[0].on_attack()
		##player hurt
		player.hurt(damage)
		await player.hurtfinished
	##enemy movement
	for i in range(enemies.size()):
		##if there is an enemy infront and they are stunned or they are at pos 1
		if enemies[i-1].squarepos+1 == enemies[i].squarepos && (enemies[i-1].stun == true || enemies[i-1].infrontplayer == true) || enemies[i].squarepos == 1:
			enemies[i].stun == true 
		##move the enemy forward if they arent stunned
		elif enemies[i].stun == false:
			enemymoved = true
			var tween = get_tree().create_tween()
			enemies[i].squarepos = enemies[i].squarepos-1
			tween.tween_property(enemies[i], "position", enemyspaces[enemies[i].squarepos-1].position, 0.375)
			if enemies[i].squarepos == 1:
				enemies[i].infrontplayer = true
	##if an enemy moved wait till the tween is finished
	if enemymoved == true:
		await get_tree().create_timer(0.375).timeout
	##to check if any tiles have damage effects
	tilecheck.emit()
	await self.tileresponseconfirmed
	##enemy logic turn
	playerturn = true
	
	
func enemydeath():
	print("Enemy died")
	enemies = enemynode.get_children()
