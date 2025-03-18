extends Control
class_name Hud

@onready var health_bar = $HealthBar

@onready var score = $Score:
	set(value):
		score.text = str(value).lpad(7, "0")

func set_max_health(health: int) -> void:
	health_bar.max_value = health
	health_bar.min_value = 0

func set_health(health: int) -> void:
	health_bar.value = health
