class_name Player extends CharacterBody2D

signal laser_shoot(laser_scene, location)
signal killed
signal hit()
signal healed()

@export var stats: PlayerStatsResource
@export var death_particle: PackedScene

@onready var muzzle = $Muzzle

var laser_scene = preload("res://scenes/lasers/laser.tscn")
var shoot_cd := false

func _physics_process(_delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(stats.fire_rate).timeout
			shoot_cd = false

func shoot():
	laser_shoot.emit(laser_scene, muzzle.global_position)
	
func take_damage(amount):
	stats.health -= amount
	
	if stats.health <= 0:
		die()
	else:
		hit.emit()

func heal(amount):
	if (stats.health + amount <= stats.max_health): 
		stats.health += amount
		healed.emit()
	

func die():
	if death_particle != null:
		var particle = death_particle.instantiate()
		particle.position = global_position
		particle.rotation = global_rotation
		particle.emitting = true
		get_tree().current_scene.add_child(particle)
		
	killed.emit()
	queue_free()

func is_max_health():
	return stats.health == stats.max_health
