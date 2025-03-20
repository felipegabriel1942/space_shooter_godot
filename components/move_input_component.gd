class_name MoveInputComponent
extends Node

@export var move_component: MoveComponent
@export var stats_resource: BaseStatsResource

func _input(event):
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"), 
		Input.get_axis("move_up", "move_down")
	)
	
	var speed = stats_resource.speed
	
	move_component.velocity = direction * speed
