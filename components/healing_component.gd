extends Node
class_name HealingComponent

@export var hurt_box_component: HurtBoxComponent
@export var stats_resource: BaseStatsResource

func _ready():
	hurt_box_component.healed.connect(_heal)

func _heal(amount: int) -> void:
	stats_resource.health += amount
	
	if stats_resource.health >= stats_resource.max_health:
		stats_resource.health = stats_resource.max_health
