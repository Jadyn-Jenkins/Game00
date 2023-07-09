extends StaticBody2D
@export var color = 0
# 0 = bluish green
# 1 = red
# 2 = yellowish green
# 3 = blue
# 4 = gray
# 5 = purple
# 6 = pink
func _ready():
	if color > 6:
		color = 6
	elif color < 0:
		color = 0
	$Sprite2D.frame = color
