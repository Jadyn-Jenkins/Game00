extends CharacterBody2D
@onready var animation = $"Z-jump/Animation1"
var running = false
var LTapCount = 0
var RTapCount = 0
var xspeed = 60
var yspeed= 30
var jumping = false
var playing = true
func _physics_process(_delta):
	if playing == true:
		doubletap()
		#movement
		var movedirx = Input.get_axis("ui_left", "ui_right")
		var movediry = Input.get_axis("ui_up", "ui_down")
		velocity.x = movedirx * xspeed
		velocity.y = movediry * yspeed
		if velocity.length() == 0:
			running = false
			if jumping == false:
				animation.play("idle")
		else:
			if velocity.x < 0:
				animation.flip_h = true
			elif velocity.x > 0:
				animation.flip_h = false
			if running == false:
				animation.play("walk")
			else:
				animation.play("run")
		#douple tap running
		if Input.is_action_just_pressed("ui_right") and running == false:
			RTapCount += 1
			$DoubleTapCounter.start()
		elif running == false and RTapCount == 2:
			running = true
			RTapCount = 0
		if Input.is_action_just_pressed("ui_left") and running == false:
			LTapCount += 1
			$DoubleTapCounter.start()
		elif running == false and LTapCount == 2:
			running = true
			LTapCount = 0
	#phyics stuff
	set_velocity(velocity)
	move_and_slide()
func doubletap():
	if running == true:
		$DoubleTapCounter.stop()
		xspeed = 110
	else:
		xspeed = 60
#timer for doubletap
func _on_DoubleTapCounter_timeout():
	RTapCount = 0
	LTapCount = 0
