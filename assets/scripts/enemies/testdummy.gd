extends CharacterBody2D
var health = 50
var hitable = false
@export var following = false
@export var speed = 30
var yspeed = float(speed/2.0)
@export var target: Node2D
@onready var agent := $NavigationAgent2D as NavigationAgent2D
var moving = false
func _ready() -> void:
	retarget()

func _physics_process(_delta):
	$Label.text = str(health)
	if health <=0:
		queue_free()
		Input.start_joy_vibration(0, 0.7, 0.5, 0.5)
	if following == true:
		var direction = to_local(agent.get_next_path_position()).normalized()
		velocity.x = direction.x * speed
		velocity.y = direction.y * yspeed
	move_and_slide()


func retarget() -> void:
	agent.target_position = target.global_position
func _on_hitbox_area_entered(area):
	if hitable == true:
		if area.name == "PlayerHurtbox":
			$AudioStreamPlayer2D.play()
			health -= 5
			Input.start_joy_vibration(0, 0.2, 0.2, 0.2)

func _on_timer_timeout():
	retarget()

func _on_detection_body_entered(body):
	if body.is_in_group("Player"):
		following = true
