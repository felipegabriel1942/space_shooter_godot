class_name Heart extends Area2D

@onready var pick_up_sound = $PickUpSound

@export var healing_points = 1

func _on_area_entered(area):
	if area is HurtBoxComponent:
		area.healed.emit(healing_points)
		pick_up_sound.play()
		
		var sound_player = AudioStreamPlayer.new()
		sound_player.stream = pick_up_sound.stream
		get_tree().current_scene.add_child(sound_player)
		sound_player.play()
		
		queue_free()
		
		await sound_player.finished
		sound_player.queue_free()
