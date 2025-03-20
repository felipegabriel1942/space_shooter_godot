extends Resource
class_name BaseStatsResource

signal no_health()

@export var fire_rate := 0.25
@export var health: int:
	set(value):
		health = value
		
		if max_health == null:
			max_health = value

@export var speed := 300

var max_health

func is_full_health() -> bool:
	return max_health == health
