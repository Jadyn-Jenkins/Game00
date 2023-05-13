extends KinematicBody2D
var velocity = Vector2(0, 0)
var jump = -260
var gravity = 10
var grounded
const FLOOR = Vector2(0, -1)

func _physics_process(_delta):
	if position.y >= -2:
		grounded = true
		velocity.y = 0
	else:
		grounded = false
		velocity.y += gravity
	if Input.is_action_just_pressed("ui_accept"):
		if grounded == true:
			velocity.y = jump
			
	move_and_slide(velocity, FLOOR)

