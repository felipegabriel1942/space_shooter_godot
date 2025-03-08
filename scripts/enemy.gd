class_name Enemy extends Area2D

signal laser_shoot(laser_scene, location)
signal killed(points)
signal hit()
signal dropped_power_up(power_up_scene, location)

@export var speed = 150
@export var health = 1
@export var points = 100
@export var death_particle: PackedScene
@export var chance_of_drop = 15

@onready var muzzle = $Muzzle

var laser_scene = preload("res://scenes/lasers/enemy_laser.tscn")
var heart_scene = preload("res://scenes/power_ups/heart.tscn")

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	if death_particle != null:
		var particle = death_particle.instantiate()
		particle.position = global_position
		particle.rotation = global_rotation
		particle.emitting = true
		get_tree().current_scene.add_child(particle)
	
	drop_power_up()
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.die()
		die()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func take_damage(amount):
	health -= amount
	
	if health <= 0:
		killed.emit(points)
		die()
	else:
		hit.emit()

func _on_laser_timer_timeout():
	laser_shoot.emit(laser_scene, muzzle.global_position)
	
func drop_power_up():
	if randf() * 100 < chance_of_drop:
		dropped_power_up.emit(heart_scene, global_position)
