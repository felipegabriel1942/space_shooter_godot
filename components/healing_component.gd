extends Node
class_name HealingComponent

@export var hurt_box: HurtBoxComponent
@export var stats: StatsComponent

func _ready():
	hurt_box.healed.connect(_heal)

func _heal(amount: int) -> void:
	stats.stats_resource.health += amount
	
	if stats.stats_resource.health >= stats.stats_resource.max_health:
		stats.stats_resource.health = stats.stats_resource.max_health
