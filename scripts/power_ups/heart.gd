class_name Heart extends Area2D

signal picked()

@export var healing_points = 1

func _on_area_entered(area):
	if area is HurtBoxComponent:
		area.healed.emit(healing_points)
		picked.emit()
		queue_free()
