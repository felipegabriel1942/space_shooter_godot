extends Control

@onready var score = $Score:
	set(value):
		score.text = str(value).lpad(7, "0")
		
@onready var max_health = $HealthBar:
	set(value):
		max_health.max_value = value
		max_health.min_value = 0

@onready var health = $HealthBar:
	set(value):
		health.value = value
