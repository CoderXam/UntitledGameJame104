extends Node2D
# Called when the node enters the scene tree for the first time.
var enemies = []
var EnemiesNode
var EnemySpaceArray = []

var round = 1.5

var player

var playerturn = true

func _ready() -> void:
	print("COMBAT_TEST READY")
	$CombatScene.refresh_pool()
	playerturn = true
	
	# THIS IS NECESSARY BECAUSE THE RUNES AUTOMATICALLY LOAD BEFORE COMBAT TEST AND COMBAT SCENE NODES!!!!!!!!!!!!
	for i in $CombatScene/Runes.get_children():
		i._ready()
	
	var Livingmoss_load = preload("res://Scenes/MonsterTemplates/Livingmoss_Template.tscn")
	var Stonyhedgehog_load = preload("res://Scenes/MonsterTemplates/Stonyhedgehog_Template.tscn")
	var Lantler_load = preload("res://Scenes/MonsterTemplates/Lantler_Template.tscn")
	var Berrybushbear_load = preload("res://Scenes/MonsterTemplates/Berrybushbear_Template.tscn")
	player = $PlayerSpace/PlayerBuild
	
	EnemySpaceArray = get_node("EnemySpaces").get_children()
	EnemiesNode = get_node("Enemies")
	
	for i in range(7):
		if (StageBuilder.stages[Global.level][i+1] !=null):
			match StageBuilder.stages[Global.level][i+1]:
				"Livingmoss":
					var LivingmossEnemy = Livingmoss_load.instantiate()
					LivingmossEnemy.squarepos = (i+1)
					EnemiesNode.add_child(LivingmossEnemy)
					LivingmossEnemy.position = EnemySpaceArray[i].position
					print("Living moss loaded in space: " + str(i+1))
				"Stonyhedgehog":
					var StonyhedgehodEnemy = Stonyhedgehog_load.instantiate()
					StonyhedgehodEnemy.squarepos = (i+1)
					EnemiesNode.add_child(StonyhedgehodEnemy)
					StonyhedgehodEnemy.position = EnemySpaceArray[i].position
					print("Stonyhedgehod loaded in space: " + str(i+1))
				"Lantler":
					var LantlerEnemy = Lantler_load.instantiate()
					LantlerEnemy.blast.connect(lantlerblast)
					LantlerEnemy.squarepos = (i+1)
					EnemiesNode.add_child(LantlerEnemy)
					LantlerEnemy.position = EnemySpaceArray[i].position
					print("Lantler loaded in space: " + str(i+1))
				"Berrybushbear":
					var BerrybushbearEnemy = Berrybushbear_load.instantiate()
					BerrybushbearEnemy.squarepos = (i+1)
					EnemiesNode.add_child(BerrybushbearEnemy)
					BerrybushbearEnemy.position = EnemySpaceArray[i].position
					print("Berrybushbear loaded in space: " + str(i+1))
	enemies = EnemiesNode.get_children()
	enemies[0].on_first()



func _on_button_pressed() -> void:
	if playerturn == true:
		playerturn = false
		enemies = EnemiesNode.get_children()
		if Global.attack[len(Global.attack)-2]!=Global.EMPTY:
			player_attack(Global.attack[len(Global.attack)-2].id)
			Global.runeDict["Cast"] = [Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY]
			Global.attack=[Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY,Global.EMPTY]
			$CombatScene.refresh_pool()

func player_attack(current_attack):
	spellcast(current_attack)
	await get_tree().create_timer(round).timeout
	enemies = EnemiesNode.get_children()
	if enemies.size()>0:
		enemy_movement()
	else:
		print("you win")
		PlayerData1.currency += 10
		Global.level += 1
		if Global.level < Global.levels+1:
			get_tree().change_scene_to_file("res://Scenes/shop/shop_scene.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/Menu Stuff/EndScreen.tscn")

#Function that moves enemies
func enemy_movement():
	#checks if enemie is in front of player and not stunned
	if enemies[0].infrontplayer == true && enemies[0].stun == false:
		#gets damage from enemy and plays attack animation
		var damage = enemies[0].on_attack()
		#waits a set amount of time so the attack animation can play
		await get_tree().create_timer(round/2).timeout
		#applies damage and plays the hurt animation
		player.hurt(damage)
	#every enemy on stage check if it can move or not
	for i in range(enemies.size()):
		if enemies[i-1].squarepos+1 == enemies[i].squarepos && (enemies[i-1].stun == true || enemies[i-1].infrontplayer == true) || enemies[i].squarepos == 1:
			enemies[i].stun = true
		elif enemies[i].stun != true:
			var tween = get_tree().create_tween()
			enemies[i].squarepos = enemies[i].squarepos-1
			tween.tween_property(enemies[i], "position", EnemySpaceArray[enemies[i].squarepos-1].position, round/4)
			if enemies[i].squarepos == 1:
				enemies[i].infrontplayer = true
	#waits until the movement round is over
	await get_tree().create_timer(round).timeout
	#update list of enemies in case one died
	enemies = EnemiesNode.get_children()
	enemies[0].on_first()
	enemy_turn()

#lets the enemy do logic stuff
func enemy_turn():
	for i in range(enemies.size()):
		enemies[i].turn()
	await get_tree().create_timer(round/2).timeout
	if player.shielded == 0:
			player.deshield()
	playerturn = true

func spellcast(spell: String):
	var chosenspell = RuneData.runedictionary[spell]
	var damage = chosenspell["damage"]
	
	# Multiplies damage by 1.2 for each supporting spell/rune
	for i in len(Global.attack)-1:
		if Global.attack[i] != Global.EMPTY:
			damage *= 1.2
	
	if chosenspell["stun"] == true:
		enemies[0].stun = true
	if chosenspell["heal"] != 0:
		player.on_heal(chosenspell["heal"])
	if chosenspell["knockback"] == true:
		if enemies.size() == 1 && enemies[0].squarepos != 7:
			var tween = get_tree().create_tween()
			tween.tween_property(enemies[0], "position", EnemySpaceArray[enemies[0].squarepos].position, round/4)
			enemies[0].squarepos = enemies[0].squarepos+1
		elif enemies[0].squarepos != 7 && enemies[0].squarepos+1 != enemies[1].squarepos:
			var tween = get_tree().create_tween()
			tween.tween_property(enemies[0], "position", EnemySpaceArray[enemies[0].squarepos].position, round/4)
			enemies[0].squarepos = enemies[0].squarepos+1
	if chosenspell["shield"] == true:
		player.on_shield()
	enemies[0].on_hurt(damage, spell)
	print(spell," did ",damage," damage!")

func lantlerblast(damage: int):
	player.lightball(damage)
