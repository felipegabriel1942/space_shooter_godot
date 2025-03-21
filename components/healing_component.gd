extends Node
class_name HealingComponent

@export var hurt_box_component: HurtBoxComponent
@export var stats_component: BaseStatsComponent

func _ready():
	hurt_box_component.healed.connect(_heal)

func _heal(amount: int) -> void:
	stats_component.health += amount
	
	if stats_component.health >= stats_component.max_health:
		stats_component.health = stats_component.max_health
