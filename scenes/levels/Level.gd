class_name Level extends Node2D

#Global Class Init

#Global variables
var lvl_1 = LevelData.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	#Simulated data retrieval for lvl 1
	lvl_1.eventQueueData.append_array(["spawn", "cutscene", "spawn", "spawn", "cutscene"]) 
	lvl_1.cutsceneQueueData.append_array(["intro_1", "carcrash_1"])
		#SpawnQueueData[  SpawnQueue[SpawnOrder[SpawnEnemyStats]]	,
		#							[SpawnOrder[SpawnEnemyStats,SpawnEnemyStats]],
		#							[SpawnOrder[SpawnEnemyStats,SpawnEnemyStats,SpawnEnemyStats]]]
		#
		#SpawnEnemyStats = [enemy_name, spawn_number, spawnside(0 = left, 1 = right, 2 = random)]
	lvl_1.spawnQueueData.append_array(
							[[["angry_patron", 2, 1]],
							[["angry_patron", 4, 2], ["knife_patron", 2, 1]],
							[["mb_jazz_minions", 4, 1], ["hammmer_patron", 3, 0], ["mb_jazz_fighter", 1, 1]]])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_event_trigger_body_entered(body):
		if body.is_in_group("Player"):
			EventBegin(lvl_1)
			#Level.getNode("EventTrigger").queue_free()

func EventBegin(levelData : LevelData):
		match levelData.eventQueueData.pop_front():
			"spawn":
				Spawn(levelData.spawnQueueData.pop_front())
			"cutscene": 
				Cutscene(levelData.cutsceneQueueData.pop_front())

func Spawn(spawnQueue):
	for i in spawnQueue.size():
		#Grab monster and spawn amount data
		var enemy = spawnQueue[i].pop_front()
		var amount = spawnQueue[i].pop_front()
		var side = spawnQueue[i].pop_front()
		
		print(enemy, " ", amount, " ", side, " ")
		
		#Randomize y-axis entrance for specified number of specified enemy on specificed side of screen

func Cutscene(cutscene):
	#init correct cutscene
	print("cutscene would start");
	
#Class Definitions
class LevelData:
	@export var eventQueueData : Array 
	@export var cutsceneQueueData : Array
	@export var spawnQueueData : Array
	
	#func getEventQueueData() -> Array:
	#	return eventQueueData
	
	#func getCutsceneData() -> Array:
	#	return cutsceneData
		
	#func getSpawnData() -> Array:
	#	return spawnData
		
	#func setEventQueueData(value):
	#	eventQueueData = value
	

