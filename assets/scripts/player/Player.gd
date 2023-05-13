extends KinematicBody2D
var velocity = Vector2()

var running = false
var TapCount = 0
var xspeed = 60
var yspeed= 30
func _physics_process(_delta):
	doubletap()
	if Input.is_action_pressed("ui_right"):
		velocity.x = xspeed
		if Input.is_action_just_pressed("ui_right") and running == false:
			TapCount += 1
			$DoubleTapCounter.start()
		elif running == false and TapCount == 2:
			running = true
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -xspeed
		if Input.is_action_just_pressed("ui_left") and running == false:
			TapCount += 1
			$DoubleTapCounter.start()
		elif running == false and TapCount == 2:
			running = true
			TapCount = 0
	else:
		velocity.x = 0
		running = false
	if Input.is_action_pressed("ui_down"):
		velocity.y = yspeed
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -yspeed
	else:
		velocity.y = 0
	move_and_slide(velocity)
func doubletap():
	if running == true:
		$DoubleTapCounter.stop()
		xspeed = 90
	else:
		xspeed = 60

func _on_DoubleTapCounter_timeout():
	TapCount = 0
