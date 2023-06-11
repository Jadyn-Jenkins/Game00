extends "res://addons/action_command/lib/action.gd"

@export var keycode: int

func test(event: InputEvent) -> int:
	if event is InputEventKey && event.keycode == keycode:
		if event.is_pressed():
			return TestResult.Active
		else:
			return TestResult.Silent
	return TestResult.NoRelevant
