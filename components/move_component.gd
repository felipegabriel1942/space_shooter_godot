class_name MoveComponent
extends Node

@export var velocity: Vector2

func _process(delta: float) -> void:
	get_parent().translate(velocity * delta)
