class_name Player extends Character

@export var jumpStr = -130
var gravity = 10

const FLOOR = Vector2(0, -1)

@export var LTapCount = 0
@export var RTapCount = 0
var xspeed = 60
var yspeed= 30
var playing = true
var direction = 1

var dblTapPath = "/root/level/player/DoubleTapCounter"
var animationPlayerPath = "/root/level/player/z-jump/Sprite/AnimationPlayer"
var spritePath = "/root/level/player/z-jump/Sprite"
var zjumpPath = "/root/level/player/z-jump/"
var audioPlayerPath = "/root/level/player/AudioStreamPlayer/"
#var animation : AnimationPlayer

var score : int
@export var dblTapTimer : Timer
var sprite
var zpos

func _ready():
	
	animationData.animation = get_node(animationPlayerPath)
	dblTapTimer = get_node(dblTapPath)
	sprite = get_node(spritePath)
	zpos = get_node(zjumpPath).position.y
	
func _init():
	pass
	
func _physics_process(_delta):
	handleStates()
	doubletap()
	catchInput()
	print(state)
	#phyics stuff
	set_velocity(velocity)
	move_and_slide()
	set_up_direction(FLOOR)


func handleStates():
	idleCheck()
	groundedCheck()
	runningCheck()
	attackingCheck()
	
	movement()
	animate()
	
#timer for doubletap
func _on_DoubleTapCounter_timeout():
	self.RTapCount = 0
	self.LTapCount = 0
# when a animation is finished, [x] happens
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "punch":
		self.idle()
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
func _on_timer_timeout():
	self.velocity.y = self.jumpStr

func animate():
	match self.state:
		"idle":
			self.animationData.animation.play("idle")
		"walking":
			self.animationData.animation.play("walk")
		"running":
			self.animationData.animation.play("run")
		"jumping":
			self.animationData.animation.play("jump")
		"jumpAttacking":
			self.animationData.animation.play("jump_kick")
		"hurt":
			self.animationData.animation.play("hurt")
		"death":
			self.animationData.animation.play("death")
		"attacking":
			self.animationData.animation.play("punch")
		TYPE_NIL:
			print("state property is acting up")
func movement():
	if self.state != "attacking" or self.state != "jumpAttacking":
		var movedirx = Input.get_axis("left_player1", "right_player1")
		var movediry = Input.get_axis("up_player1", "down_player1")
		self.velocity.x = movedirx * self.xspeed
		self.velocity.y = movediry * self.yspeed
func groundedCheck():
	if self.position.y >= -2:
		self.grounded = true
		
		if self.state == "jumpAttack":
			end_jumpkick()
			
	else:
		self.grounded = false
		self.velocity.y += gravity
func idleCheck():
	if self.velocity.length() == 0 and grounded == true and self.state != "attacking":
		self.idle()
	else:
		if self.state != "attacking":				
			#flipping the sprite and its collisions
			flipSprite()
			
		# running or walking
		if self.velocity.length() > 0 and self.state != "running" and self.state != "jumping":
			self.walk()
			animate()
		else:
			self.run()
			animate()
func runningCheck():
	if self.state == "running":
		self.jumpStr = -290
	else:
		self.jumpStr = -260
func attackingCheck():
	#attempitng to make a lag when attack is kicked so you can't inifintely clickit for max speed shit
	while self.animationData.animation.is_playing() and (state == "attacking" or state == "jumpAttacking"):
		pass

#ending jumpkick so the isn't jumpkicking forever
func end_jumpkick():
	#Stops jump from decending past the floor
	self.velocity.y = 0
	self.idle()
	animate()

func flipSprite():
	if self.velocity.x > 0:
		self.scale.y = 1
		self.rotation_degrees = 0
	elif self.velocity.x < 0:
		self.rotation_degrees = 180
		self.scale.y = -1
func updateScore(score : int):
	#Update score logic goes here
	pass
	
#douletap system
func doubletap():
	if self.state == "running":
		self.dblTapTimer.stop()
		self.xspeed = 110
	else:
		self.xspeed = 60

func specialAttack():
	#Special Attack goes here
	pass
	
func catchInput():
	jumpCheck()
	attackCheck()
	doubleTapRunning()

		
func handleInput(input_just_pressed : String):
	#Make button presses here
	pass
	
func attackCheck():
	if Input.is_action_just_pressed("punch_player1"):
		#Reset double tap count
		self.RTapCount = 0
		self.LTapCount = 0
		
		#Jump attack
		if self.state == "jumping":
			jumpAttack()
			animate()
		#Grounded attack
		else:
			attack()
			animate()
			
			#stop from moving while in attack
			self.velocity.x *= 0
			self.velocity.y *= 0
			self.get_node(audioPlayerPath).play()
			
func doubleTapRunning():
	if Input.is_action_just_pressed("right_player1") and self.state != "running":
		#flips sprite to face movement to the right
		if self.scale.x != self.scale.x * -1:
			self.scale.x = -1
		self.walk()
		animate()
		
		#Resets left run counter and incriments the right run counter then starts a timer waiting for second right input	
		LTapCount = 0
		RTapCount += 1
		dblTapTimer.start()
	#Checks for right run counter will allow for running
	elif self.state == "walking" and self.RTapCount == 2:
		self.run()
		animate()
		RTapCount = 0
	
	if Input.is_action_just_pressed("left_player1") and self.state != "running":
		#flips sprite to face movement to the left
		if self.scale.x != self.scale.x * -1:
			self.scale.x = -1
		if self.scale.x != 1:
			self.scale.x = -1
		self.walk()
		animate()
		
		#Resets right run counter and incriments the left run counter then starts a timer waiting for second left input
		self.RTapCount = 0
		self.LTapCount += 1
		self.dblTapTimer.start()
		
	#Checks for left run counter will allow for running
	elif self.state == "walking" and self.LTapCount == 2:
		self.run()
		animate()
		self.LTapCount = 0
		
	if Input.is_action_just_pressed("down_player1") or Input.is_action_just_pressed("up_player1"):
		# Reset left and right counter when down/up ward movement is entered
		self.RTapCount = 0
		self.LTapCount = 0

func jumpCheck():
	if Input.is_action_just_pressed("jump_player1") and self.grounded == true:
		#Horizontal speed keeps with the jump
		self.velocity.y = self.jumpStr
		self.jump()
		animate()
		
		# Reset left and right counter when a jump is entered
		self.LTapCount = 0
		self.RTapCount = 0
		


