extends CharacterBody2D
@onready var animation = $"Z-jump/Sprite/AnimationPlayer"
@onready var sprite = $"Z-jump/Sprite"
var running = false
var LTapCount = 0
var RTapCount = 0
var xspeed = 60
var yspeed= 30
var jumping = false
var playing = true
var attacking = false
var jumpkick = false
var direction = 1
@onready var zpos = $"Z-jump".position.y
func _physics_process(_delta):
	if jumping == true:
		if attacking == false:
			animation.play("jump")
	doubletap()
	#attacking
	if Input.is_action_just_pressed("punch_player1"):
		RTapCount = 0
		LTapCount = 0
		if jumping == true:
			attacking = true
			jumpkick = true
			if jumpkick == true:
				animation.play("jump_kick")
		elif jumping == false:
			attacking = true
			animation.play("punch")
			velocity.x *= 0
			velocity.y *= 0
			$AudioStreamPlayer.play()
			pass
	#movement
	if attacking == false:
			var movedirx = Input.get_axis("left_player1", "right_player1")
			var movediry = Input.get_axis("up_player1", "down_player1")
			velocity.x = movedirx * xspeed
			velocity.y = movediry * yspeed
	if velocity.length() == 0:
		running = false
		if jumping == false:
			if attacking == false:
				animation.play("idle")
	else:
		if attacking == false:
			if jumpkick == false:
				#flipping the sprite and its collisions
				if velocity.x > 0:
					scale.y = 1
					rotation_degrees = 0
				elif velocity.x < 0:
					rotation_degrees = 180
					scale.y = -1
				# running or walking
				if running == false:
					if jumping == false:
						animation.play("walk")
				else:
						animation.play("run")
	#douple tap running
	if Input.is_action_just_pressed("right_player1") and running == false:
		if scale.x != scale.x * -1:
			scale.x = -1
		LTapCount = 0
		RTapCount += 1
		$DoubleTapCounter.start()
	elif running == false and RTapCount == 2:
		running = true
		RTapCount = 0
	if Input.is_action_just_pressed("left_player1") and running == false:
		if scale.x != scale.x * -1:
			scale.x = -1
		if scale.x != 1:
			scale.x = -1
		RTapCount = 0
		LTapCount += 1
		$DoubleTapCounter.start()
	elif running == false and LTapCount == 2:
		running = true
		LTapCount = 0
	#reseting double tap when going up or down
	if Input.is_action_just_pressed("jump_player1") or Input.is_action_just_pressed("down_player1"):
		RTapCount = 0
		LTapCount = 0
	#phyics stuff
	set_velocity(velocity)
	move_and_slide()
#ending jumpkick so the isn't jumpkicking forever
func end_jumpkick():
	attacking = false
	jumpkick = false
#douletap system
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
# when a animation is finished, [x] happens
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "punch":
		attacking = false
	if anim_name == "jump_kick":
		pass


func _on_range_body_entered(body):
	if body.name == "testdummy":
		if body.hitable != true:
			body.hitable = true
	if body.name == "mailbox":
		if body.hitable != true:
			body.hitable = true


func _on_range_body_exited(body):
	if body.name == "testdummy":
		if body.hitable != false:
			body.hitable = false
	if body.name == "mailbox":
		if body.hitable != false:
			body.hitable = false
