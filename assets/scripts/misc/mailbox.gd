extends StaticBody2D

@export var item = 0
var health = 40
var hitable = false
#1 = food_item_1
#2 = food_item_2
#3 = 1up
#4 = points
#feel free to add more
func _ready():
	$AnimationPlayer.play("idle")
	$Sprite2D.visible = true
	$"mail-hitbox/CollisionShape2D".disabled = false

func _on_mailhitbox_area_entered(area):
	if hitable == true:
		if area.name == "PlayerHurtbox":
			$Sprite2D.offset.y = -16
			$AnimationPlayer.play("broken")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "broken":
		queue_free()
