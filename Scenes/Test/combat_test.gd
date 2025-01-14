extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Livingmoss_load = preload("res://Scenes/MonsterTemplates/Livingmoss_Template.tscn")
	var Stonyhedgehog_load = preload("res://Scenes/MonsterTemplates/Stonyhedgehog_Template.tscn")
	var Lantler_load = preload("res://Scenes/MonsterTemplates/Lantler_Template.tscn")
	var Berrybushbear_load = preload("res://Scenes/MonsterTemplates/Berrybushbear_Template.tscn")
	
	var EnemySpaceArray = get_node("EnemySpaces").get_children()
	
	for i in range(7):
		if (StageBuilder.stage1[i+1] !=null):
			match StageBuilder.stage1[i+1]:
				"Livingmoss":
					var LivingmossEnemy = Livingmoss_load.instantiate()
					EnemySpaceArray[i].add_child(LivingmossEnemy)
					print("Living moss loaded in space: " + str(i+1))
				"Stonyhedgehod":
					var StonyhedgehodEnemy = Stonyhedgehog_load.instantiate()
					EnemySpaceArray[i].add_child(StonyhedgehodEnemy)
					print("Stonyhedgehod loaded in space: " + str(i+1))
				"Lantler":
					var LantlerEnemy = Lantler_load.instantiate()
					EnemySpaceArray[i].add_child(LantlerEnemy)
					print("Lantler loaded in space: " + str(i+1))
				"Berrybushbear":
					var BerrybushbearEnemy = Berrybushbear_load.instantiate()
					EnemySpaceArray[i].add_child(BerrybushbearEnemy)
					print("Berrybushbear loaded in space: " + str(i+1))
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
