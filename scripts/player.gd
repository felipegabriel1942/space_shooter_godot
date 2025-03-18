class_name Player extends CharacterBody2D

signal laser_shoot(laser_scene, location)
signal healed()

@onready var muzzle = $Muzzle
@onready var stats = $StatsComponent as StatsComponent
@onready var hurt_box = $HurtBoxComponent as HurtBoxComponent

var laser_scene = preload("res://scenes/lasers/laser.tscn")
var shoot_cd := false

func _physics_process(_delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(stats.stats_resource.fire_rate).timeout
			shoot_cd = false

func shoot():
	laser_shoot.emit(laser_scene, muzzle.global_position)

func heal(amount):
	if (stats.stats_resource.health + amount <= stats.stats_resource.max_health): 
		stats.stats_resource.health += amount
		healed.emit()

func is_max_health():
	return stats.stats_resource.health == stats.stats_resource.max_health
