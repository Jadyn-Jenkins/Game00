extends CharacterBody2D

var running = false
var LTapCount = 0
var RTapCount = 0
var xspeed = 60
var yspeed= 30
func _physics_process(_delta):
	doubletap()
	if Input.is_action_pressed("ui_right"):
		velocity.x = xspeed
		if Input.is_action_just_pressed("ui_right") and running == false:
			RTapCount += 1
			$DoubleTapCounter.start()
		elif running == false and RTapCount == 2:
			running = true
			RTapCount = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -xspeed
		if Input.is_action_just_pressed("ui_left") and running == false:
			LTapCount += 1
			$DoubleTapCounter.start()
		elif running == false and LTapCount == 2:
			running = true
			LTapCount = 0
	else:
		velocity.x = 0
		running = false
	if Input.is_action_pressed("ui_down"):
		velocity.y = yspeed
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -yspeed
	else:
		velocity.y = 0
	set_velocity(velocity)
	move_and_slide()
func doubletap():
	if running == true:
		$DoubleTapCounter.stop()
		xspeed = 110
	else:
		xspeed = 60

func _on_DoubleTapCounter_timeout():
	RTapCount = 0
	LTapCount = 0
