extends CharacterBody2D

var jump = -260
var gravity = 10
var grounded
const FLOOR = Vector2(0, -1)
func running():
	if get_parent().running == true:
		jump = -290
	else:
		jump = -260
func _physics_process(_delta):
	running()
	if position.y >= -2:
		grounded = true
		velocity.y = 0
	else:
		grounded = false
		velocity.y += gravity
	if Input.is_action_just_pressed("ui_accept"):
		if grounded == true:
			velocity.y = jump
			
	set_velocity(velocity)
	set_up_direction(FLOOR)
	move_and_slide()

