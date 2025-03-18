extends Node
class_name DamageComponent

@export var hurt_box: HurtBoxComponent
@export var stats: StatsComponent

func _ready():
	hurt_box.hurt.connect(_cause_damage)

func _cause_damage(amount: int) -> void:
	stats.stats_resource.health -= amount
	
	if stats.stats_resource.health <= 0:
		stats.stats_resource.health = 0
		stats.stats_resource.no_health.emit()
