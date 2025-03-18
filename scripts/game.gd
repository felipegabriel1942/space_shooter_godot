extends Node2D

@export var enemy_scenes: Array[PackedScene] = []

@onready var player = $Player as Player
@onready var player_spawn_pos = $PlayerSpawnPos
@onready var laser_container = $LaserContainer
@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var hud = $UILayer/HUD as Hud
@onready var game_over_screen = $UILayer/GameOverScreen
@onready var parallax_background = $ParallaxBackground
@onready var laser_sound = $SFX/LaserSound
@onready var hit_sound = $SFX/HitSound
@onready var explode_sound = $SFX/ExplodeSound
@onready var pick_up_power_up_sound = $SFX/PickUpPowerUpSound
@onready var power_up_container = $PowerUpContainer

# setter implementation
var score := 0:
	set(value):
		score = value
		hud.score = score

var high_score
var background_scroll_speed := 100
	
func _ready():
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	
	if save_file != null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
	
	hud.score = 0
	hud.set_max_health(player.stats.stats_resource.max_health)
	hud.set_health(player.stats.stats_resource.health)
	
	player.global_position = player_spawn_pos.global_position
	player.laser_shoot.connect(_on_laser_shot)
	player.stats.stats_resource.no_health.connect(_on_player_killed)
	player.hurt_box.hurt.connect(_on_player_hit)
	player.hurt_box.healed.connect(_on_player_healed)

func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(high_score)

func _process(delta):
	if  Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
	if enemy_spawn_timer.wait_time > 0.5:
		enemy_spawn_timer.wait_time -= delta * 0.005
	elif enemy_spawn_timer.wait_time < 0.5:
		enemy_spawn_timer.wait_time = 0.5
	
	parallax_background.scroll_offset.y += delta * background_scroll_speed
	
	if parallax_background.scroll_offset.y >= 960:
		parallax_background.scroll_offset.y = 0

func _on_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	laser_sound.play()

func _on_enemy_spawn_timer_timeout():
	var enemy = enemy_scenes.pick_random().instantiate()
	enemy.global_position = Vector2(randf_range(50, 500), 50)
	enemy.killed.connect(_on_enemy_killed)
	enemy.laser_shoot.connect(_on_laser_shot)
	enemy.hit.connect(_on_enemy_hit)
	enemy.dropped_power_up.connect(_on_power_up_dropped)
	enemy_container.add_child(enemy)

func _on_enemy_killed(points):
	explode_sound.play()
	score += points
	
	if score > high_score:
		high_score = score

func _on_enemy_hit():
	hit_sound.play()
	
func _on_player_hit(_amount: int):
	hit_sound.play()
	hud.set_health(player.stats.stats_resource.health)

func _on_player_killed():
	explode_sound.play()
	game_over_screen.set_score(score)
	game_over_screen.set_high_score(high_score)
	hud.set_health(player.stats.stats_resource.health)
	await get_tree().create_timer(1.5).timeout
	game_over_screen.visible = true
	save_game()

func _on_player_healed(amount: int):
	hud.set_health(player.stats.stats_resource.health)

func _on_heart_picked():
	pick_up_power_up_sound.play()

func _on_power_up_dropped(power_up_scene, location):
	if !player.is_max_health():
		var power_up = power_up_scene.instantiate()
		power_up.global_position = location
		power_up.picked.connect(_on_heart_picked)
		power_up_container.add_child(power_up)

