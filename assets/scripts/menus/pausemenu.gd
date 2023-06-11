extends Control
@onready var resume = $MarginContainer/VBoxContainer/resume
@onready var restart = $MarginContainer/VBoxContainer/restart
@onready var options = $MarginContainer/VBoxContainer/options
@onready var mainmenu = $MarginContainer/VBoxContainer/mainmanu
func _ready():
	resume.grab_focus()
	
func _physics_process(_delta):
	if resume.is_hovered():
		resume.grab_focus()
	if restart.is_hovered():
		restart.grab_focus()
	if options.is_hovered():
		options.grab_focus()
	if mainmenu.is_hovered():
		mainmenu.grab_focus()
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		resume.grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible
	
func _on_quit_pressed():
	get_tree().quit()


func _on_resume_pressed():
	resume.grab_focus()
	get_tree().paused = not get_tree().paused
	visible = not visible


func _on_options_pressed():
	pass # Replace with function body.


func _on_mainmanu_pressed():
	pass # Replace with function body.


func _on_restart_pressed():
	pass # Replace with function body.
