class_name Enemy extends Area2D

signal laser_shoot(laser_scene, location)
signal killed(points)
signal hit()
signal dropped_power_up(power_up_scene, location)

@export var death_particle: PackedScene
@export var stats_component: BaseStatsComponent

@onready var muzzle = $Muzzle
@onready var flash_component = $FlashComponent as FlashComponent
@onready var hurt_box_component = $HurtBoxComponent as HurtBoxComponent

var laser_scene = preload("res://scenes/lasers/enemy_laser.tscn")
var heart_scene = preload("res://scenes/power_ups/heart.tscn")

func die():
	drop_power_up()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_laser_timer_timeout():
	laser_shoot.emit(laser_scene, muzzle.global_position)
	
func drop_power_up():
	if randf() * 100 < stats_component.chance_of_drop:
		dropped_power_up.emit(heart_scene, global_position)

func _on_area_entered(area):
	if area is HurtBoxComponent:
		area.hurt.emit(1)
		die()
