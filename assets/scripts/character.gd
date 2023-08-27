class_name Character extends CharacterBody2D

	# State should change fliudly with the players's inputs. States is the library of possible states
	# any character might be in	
	# Idle = 0
	# Walking = 1
	# Running = 2
	# Jumping = 3
	# jumpAttacking = 4
	# Hurt = 5
	# Death = 6
	# Attacking = 7
var states = ["idle", "walking", "running", "jumping", "jumpAttacking", "hurt", "death", "attacking"]
@export var state : String = states[0]
@export var grounded : bool = true
var health : int = 100
var animationData : AnimationData = AnimationData.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	idle()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func idle():
	state = states[0]
	
func walk():
	state = states[1]
	
func run():
	state = states[2]

func jump():
	state = states[3]

func jumpAttack():
	state = states[4]

func takeDamage(damage):
	state = states[5]

func death():
	state = states[6]

func attack():
	state = states[7]
