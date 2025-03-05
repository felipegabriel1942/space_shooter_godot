class_name Player extends CharacterBody2D

signal laser_shoot(laser_scene, location)
signal killed
signal hit()

@export var speed = 300
@export var fire_rate = 0.25
@export var health = 3
@export var death_particle: PackedScene

@onready var muzzle = $Muzzle

var laser_scene = preload("res://scenes/laser.tscn")
var shoot_cd := false

func _physics_process(_delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(fire_rate).timeout
			shoot_cd = false
	
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"), 
		Input.get_axis("move_up", "move_down")
	)
	
	velocity = direction * speed
	
	move_and_slide()
	
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)

func shoot():
	laser_shoot.emit(laser_scene, muzzle.global_position)
	
func take_damage(amount):
	health -= amount
	
	if health <= 0:
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
		
	killed.emit()
	queue_free()
