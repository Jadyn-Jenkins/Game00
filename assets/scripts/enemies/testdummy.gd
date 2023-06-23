extends CharacterBody2D
var health = 40

func _physics_process(delta):
	$Label.text = str(health)
	if health <=0:
		queue_free()

func _on_hitbox_area_entered(area):
	if $RayCast2D.is_colliding() or $RayCast2D2.is_colliding():
		health -= 5
