@tool
extends Sprite2D
class_name ControllerSprite

@export var path: String : String = "": set = set_path
@export var show_only : int = 0: set = set_show_only
@export var force_type : int = 0: set = set_force_type

func _ready():
	ControllerIcons.connect("input_type_changed", Callable(self, "_on_input_type_changed"))
	set_path(path)

func _on_input_type_changed(input_type):
	if show_only == 0 or \
		(show_only == 1 and input_type == ControllerIcons.InputType.KEYBOARD_MOUSE) or \
		(show_only == 2 and input_type == ControllerIcons.InputType.CONTROLLER):
		visible = true
		set_path(path)
	else:
		visible = false

func set_path(_path: String):
	path = _path
	if is_inside_tree():
		if force_type > 0:
			texture = ControllerIcons.parse_path(path, force_type - 1)
		else:
			texture = ControllerIcons.parse_path(path)

func set_show_only(_show_only: int):
	show_only = _show_only
	_on_input_type_changed(ControllerIcons._last_input_type)

func set_force_type(_force_type: int):
	force_type = _force_type
	_on_input_type_changed(ControllerIcons._last_input_type)
