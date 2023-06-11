extends Node2D
func _ready():
	$"press-start/button-flashing".play("any-button")
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			$transition/animation.play_backwards("transition")
