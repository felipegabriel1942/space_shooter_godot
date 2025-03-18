extends Resource
class_name BaseStatsResource

signal no_health()

@export var fire_rate := 0.25
@export var health: int:
	set(value):
		health = value
		max_health = value
@export var speed := 300

var max_health := 0
