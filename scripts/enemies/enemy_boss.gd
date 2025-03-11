class_name EnemyBoss extends Area2D

signal killed(points)
signal hit()

@export var health = 20
@export var death_particle: PackedScene
@export var points = 20000

func take_damage(amount):
	health -= amount
	
	print(health)
	
	if health <= 0:
		killed.emit(points)
		die()
	else:
		hit.emit()

func die():
	if death_particle != null:
		var particle = death_particle.instantiate()
		particle.position = global_position
		particle.rotation = global_rotation
		particle.emitting = true
		get_tree().current_scene.add_child(particle)
	
	queue_free()
