extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			get_tree().quit()
