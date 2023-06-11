extends Resource
class_name PlayerData

var high
var time = Time.get_datetime_dict_from_system();
var day = str(time.day);
var month = str(time.month);
var year = str(time.year);
var level
var slotname
var filepath = ("user://saved_data.")+str(slot)
var slot = 1
func _ready():
	print(month,".",day,".", year)
	
