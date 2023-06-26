extends CharacterBody2D
var health = 50
var path
@export var speed = 30
var yspeed = float(speed/2)
@export var target: Node2D
@onready var agent := $NavigationAgent2D as NavigationAgent2D
var moving = false
func _ready() -> void:
	retarget()

func _physics_process(_delta):
	$Label.text = str(health)
	if health <=0:
		queue_free()
	var direction = to_local(agent.get_next_path_position()).normalized()
	velocity.x = direction.x * speed
	velocity.y = direction.y * yspeed
	move_and_slide()


func retarget() -> void:
	agent.target_position = target.global_position
func _on_hitbox_area_entered(area):
	if $RayCast2D.is_colliding() or $RayCast2D2.is_colliding():
		if area.name == "PlayerHurtbox":
			health -= 5
	

func _on_timer_timeout():
	retarget()
