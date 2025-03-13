extends Resource
class_name PlayerStatsResource

@export var fire_rate := 0.25
@export var health := 0:
	set(value):
		health = value
		max_health = value
		

var max_health: int
