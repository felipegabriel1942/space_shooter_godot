class_name PositionClampComponent
extends Node2D

func _process(_delta: float) -> void:
	get_parent().global_position = get_parent().global_position.clamp(Vector2.ZERO, get_viewport_rect().size)
