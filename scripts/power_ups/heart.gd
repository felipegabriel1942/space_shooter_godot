class_name Heart extends Area2D

signal picked()

@export var healing_points = 1

func _on_body_entered(body):
	if body is Player:
		body.heal(healing_points)
		picked.emit()
		queue_free()
