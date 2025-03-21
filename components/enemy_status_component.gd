extends BaseStatsComponent
class_name EnemyStatsComponent

signal destroyed(points: int)

@export var points: int;
@export var chance_of_drop: float;

func _ready():
	died.connect(_on_destroyed)
	
func _on_destroyed():
	destroyed.emit(points)
