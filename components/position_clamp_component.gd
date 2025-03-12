class_name PositionClampComponent
extends Node2D

@export var actor: Node2D

func _process(_delta: float) -> void:
	actor.global_position = actor.global_position.clamp(Vector2.ZERO, get_viewport_rect().size)
