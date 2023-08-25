class_name Character extends CharacterBody2D

	# State should change fliudly with the players's inputs. States is the library of possible states
	# any character might be in	
	# Still = 0
	# Walking = 1
	# Running = 2
	# Jumping = 3
	# jumpAttack = 4
	# Attacking = 5
	# Hurt = 6
	# Death = 7
	# PowerUp = 8	
	# 
var states = ["idle", "walking", "running", "jumping", "jumpAttacking","attacking", "hurt", "death", "powerUp"]

var state : String = states[0]
var health : int
var animationData : AnimationData

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func move(input):
	state = states[1]

func attack(input):
	if state == "jumping" & input == "attack":
		jumpAttack()
	else :
		state = states[5]

func jump(input):
	state = states[3]

func jumpAttack():
	state = states[4]

func takeDamage(damage):
	state = states[6]

func death():
	state = states[7]
