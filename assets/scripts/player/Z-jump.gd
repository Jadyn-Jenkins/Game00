extends CharacterBody2D

@export var jump = -130
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
		if get_parent().jumpkick == true:
			get_parent().end_jumpkick()
		velocity.y = 0
		get_parent().jumping = false
	else:
		grounded = false
		velocity.y += gravity
	if Input.is_action_just_pressed("jump_player1"):
		if grounded == true:
			get_parent().jumping = true
			velocity.y = jump
			
			get_parent().LTapCount = 0
			get_parent().RTapCount = 0

			
	set_velocity(velocity)
	set_up_direction(FLOOR)
	move_and_slide()

func _on_timer_timeout():
	velocity.y = jump
