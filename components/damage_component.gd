extends Node
class_name DamageComponent

@export var hurt_box_component: HurtBoxComponent
@export var stats_resource: BaseStatsResource

func _ready():
	hurt_box_component.hurt.connect(_cause_damage)

func _cause_damage(amount: int) -> void:
	stats_resource.health -= amount
	
	if stats_resource.health <= 0:
		stats_resource.health = 0
		stats_resource.no_health.emit()
