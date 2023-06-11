extends CharacterBody2D

var xspeed = 100
var yspeed= 50
func _physics_process1(_delta):
	pass
	set_velocity(velocity)
	move_and_slide()
