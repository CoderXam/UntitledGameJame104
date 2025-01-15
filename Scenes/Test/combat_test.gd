extends Node2D
var enemyid =0
# Called when the node enters the scene tree for the first time.
var enemies = []
var EnemiesNode
var EnemySpaceArray = []

var round = 1.5

signal attack

func _ready() -> void:
	var Livingmoss_load = preload("res://Scenes/MonsterTemplates/Livingmoss_Template.tscn")
	var Stonyhedgehog_load = preload("res://Scenes/MonsterTemplates/Stonyhedgehog_Template.tscn")
	var Lantler_load = preload("res://Scenes/MonsterTemplates/Lantler_Template.tscn")
	var Berrybushbear_load = preload("res://Scenes/MonsterTemplates/Berrybushbear_Template.tscn")
	
	EnemySpaceArray = get_node("EnemySpaces").get_children()
	EnemiesNode = get_node("Enemies")
	
	for i in range(7):
		enemyid =1
		if (StageBuilder.stage1[i+1] !=null):
			match StageBuilder.stage1[i+1]:
				"Livingmoss":
					var LivingmossEnemy = Livingmoss_load.instantiate()
					LivingmossEnemy.squarepos = (i+1)
					EnemiesNode.add_child(LivingmossEnemy)
					LivingmossEnemy.position = EnemySpaceArray[i].position
					print("Living moss loaded in space: " + str(i+1))
				"Stonyhedgehod":
					var StonyhedgehodEnemy = Stonyhedgehog_load.instantiate()
					StonyhedgehodEnemy.squarepos = (i+1)
					EnemiesNode.add_child(StonyhedgehodEnemy)
					StonyhedgehodEnemy.position = EnemySpaceArray[i].position
					print("Stonyhedgehod loaded in space: " + str(i+1))
				"Lantler":
					var LantlerEnemy = Lantler_load.instantiate()
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
			enemyid=enemyid+1
	enemies = EnemiesNode.get_children()




func _on_button_pressed() -> void:
	enemies = EnemiesNode.get_children()
	player_attack("fire")
	#PlayerAttack
	
	

func player_attack(current_attack):
	match current_attack:
		"fire":
			enemies[0].on_hurt(5)
			pass
		"lifesteal":
			pass
		"lightning":
			pass
		"magma":
			pass
		"orb":
			pass
		"root":
			enemies[0].stun = true
			enemies[0].on_hurt(5)
		"shield":
			pass
		"thorns":
			pass
		"water":
			pass
	await get_tree().create_timer(round/2).timeout
	enemies = EnemiesNode.get_children()
	enemy_movement()
func enemy_movement():
	if enemies[0].infrontplayer == true && enemies[0].stun == false:
		var damage = enemies[0].on_attack()
		await get_tree().create_timer(round/2).timeout
		$PlayerSpace/PlayerCombat.hurt(damage)
	for i in range(enemies.size()):
		if enemies[i-1].squarepos+1 == enemies[i].squarepos && (enemies[i-1].stun == true || enemies[i-1].infrontplayer == true) || enemies[i].squarepos == 1:
			enemies[i].stun = true
		elif enemies[i].stun != true:
			var tween = get_tree().create_tween()
			enemies[i].squarepos = enemies[i].squarepos-1
			tween.tween_property(enemies[i], "position", EnemySpaceArray[enemies[i].squarepos-1].position, round/4)
			if enemies[i].squarepos == 1:
				enemies[i].infrontplayer = true		
	await get_tree().create_timer(round).timeout
	enemies = EnemiesNode.get_children()
	enemy_turn()
func enemy_turn():
	for i in range(enemies.size()):
		enemies[i].turn()
	
	
