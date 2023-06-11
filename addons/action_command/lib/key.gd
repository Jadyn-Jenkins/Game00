extends CommandAction

class_name CommandKey, "action.png"

@export (int) var keycode

func test(event: InputEvent) -> int:
	if event is InputEventKey && event.keycode == keycode && !event.is_echo():
		if event.is_pressed():
			return TestResult.Active
		else:
			return TestResult.Silent
	return TestResult.NoRelevant
