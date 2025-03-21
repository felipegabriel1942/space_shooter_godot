extends Node
class_name DamageComponent

@export var hurt_box_component: HurtBoxComponent
@export var stats_component: BaseStatsComponent

## Apply damage if collides with another HurtBoxComponent
@export var damage_on_collision = false

func _ready():
	hurt_box_component.hurt.connect(_cause_damage)
	hurt_box_component.area_entered.connect(_on_collision)

func _cause_damage(amount: int) -> void:
	stats_component.health -= amount
	
	if stats_component.health <= 0:
		stats_component.health = 0

func _on_collision(area):
	if area is HurtBoxComponent && damage_on_collision:
		hurt_box_component.hurt.emit(1)
