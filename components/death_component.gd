extends Node
class_name DeathComponent

@export var stats_component: BaseStatsComponent
@export var death_particle: PackedScene
@export var hurt_box_component: HurtBoxComponent

## Destroy actor if collides with another HurtBoxComponent
@export var death_on_collision = false

func _ready() -> void:
	stats_component.died.connect(die)
	hurt_box_component.area_entered.connect(_on_collision)

func die() -> void:
	if death_particle != null:
		var particle = death_particle.instantiate()
		particle.position = get_parent().global_position
		particle.rotation = get_parent().global_rotation
		particle.emitting = true
		get_tree().current_scene.add_child(particle)
	
	get_parent().queue_free()

func _on_collision(area):
	if area is HurtBoxComponent && death_on_collision:
		die()
