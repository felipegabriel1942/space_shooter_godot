extends Node
class_name DeathComponent

@export var stats_component: StatsComponent
@export var death_particle: PackedScene

func _ready() -> void:
	stats_component.stats_resource.no_health.connect(die)

func die() -> void:
	if death_particle != null:
		var particle = death_particle.instantiate()
		particle.position = get_parent().global_position
		particle.rotation = get_parent().global_rotation
		particle.emitting = true
		get_tree().current_scene.add_child(particle)
	
	get_parent().queue_free()
