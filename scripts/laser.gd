extends Area2D

@export var speed = 600
@export var damage = 1

@export var death_particle: PackedScene

func _physics_process(delta):
	global_position.y += -speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area is Enemy:
		area.take_damage(damage)
		
		if death_particle != null:
			var particle = death_particle.instantiate()
			particle.position = global_position
			particle.rotation = global_rotation
			particle.amount = 3
			particle.process_material.set("initial_velocity", 50)
			particle.scale = Vector2(0.5, 0.5)
			particle.emitting = true
			get_tree().current_scene.add_child(particle)
		
		queue_free()
