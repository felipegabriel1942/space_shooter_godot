extends Node
class_name BaseStatsComponent

signal died()
signal health_changed(actual: int)

@export var fire_rate := 0.25
@export var health: int:
	set(value):
		health = value
		
		health_changed.emit(health)
		
		if max_health == null:
			max_health = value
			
		if health == 0:
			died.emit()

@export var speed := 300

var max_health

func is_full_health() -> bool:
	return max_health == health
