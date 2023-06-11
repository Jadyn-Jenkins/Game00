extends Button
var playerdata = PlayerData.new()
var day
var month
var year
var level = 1
var slotname = "new file"
var percent = round(float(level)/8*100)
var filepath = ("user://saved_data.")+str(slot)
@export var slot = 0
func _ready():
	#print(percent)
	print(str(slot))
func load_data():
	playerdata = ResourceLoader.load(filepath)

func save_data():
	ResourceSaver.save(playerdata, filepath)
	

