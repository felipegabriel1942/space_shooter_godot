class_name Player extends CharacterBody2D

signal laser_shoot(laser_scene, location)
signal healed()

@onready var muzzle = $Muzzle
@export var stats_resource = PlayerStatsResource
@onready var hurt_box_component = $HurtBoxComponent as HurtBoxComponent

var laser_scene = preload("res://scenes/lasers/laser.tscn")
var shoot_cd := false

func _physics_process(_delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(stats_resource.fire_rate).timeout
			shoot_cd = false

func shoot():
	laser_shoot.emit(laser_scene, muzzle.global_position)
