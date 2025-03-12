extends Area2D

@export var damage = 1
@export var death_particle: PackedScene

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)
	
	queue_free()
