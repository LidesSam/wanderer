extends Node

@export var mainMusic : AudioStream = load("res://assets/music/WanderingMarch.wav")
@export var battleMusic : AudioStream= load("res://assets/music/Encounter.wav")
@onready var musicPlayer: AudioStreamPlayer =$musicPlayer
@onready var altMusicPlayer: AudioStreamPlayer=$altMusicPlayer
@export var fade_duration : float =0.10# Duration of fade in seconds

# Called when the node enters the scene tree for the first time.
func _ready():
	musicPlayer = AudioStreamPlayer.new()
	altMusicPlayer = AudioStreamPlayer.new()
	add_child(musicPlayer)
	add_child(altMusicPlayer)
func start():
	musicPlayer.volume_db=-20.0
	altMusicPlayer.volume_db=-80.0
	musicPlayer.stream= mainMusic
	altMusicPlayer.stream= battleMusic
	musicPlayer.play()
	altMusicPlayer.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

func enter_battle():
	fade_music(musicPlayer, altMusicPlayer, battleMusic)

func out_battle():
	fade_music(altMusicPlayer, musicPlayer, mainMusic)

# Fade out the current player and fade in the new player
func fade_music(from_player, to_player, new_stream):
	to_player.stream = new_stream
	to_player.play()
	from_player.volume_db = -20.0
	to_player.volume_db = -80.0

	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = fade_duration
	timer.connect("timeout", Callable(self, "_on_fade_complete").bind(from_player, to_player))
	add_child(timer)
	timer.start()

	fade_out(from_player, fade_duration)
	fade_in(to_player, fade_duration)

func _on_fade_complete(from_player, to_player):
	from_player.stop()
	from_player.volume_db = -80.0 # Reset volume to minimum for the inactive player
	to_player.volume_db = -20.0 # Set volume to normal for the active player

# Utility functions to perform the fade in and fade out
func fade_out(player, duration):
	var step = 0.1
	var current_volume = player.volume_db
	while current_volume > -80.0:
		current_volume -= step
		player.volume_db = current_volume
		await get_tree().create_timer(duration / ((80 - current_volume) / step)).timeout

func fade_in(player, duration):
	var step = 0.1
	var current_volume = player.volume_db
	while current_volume < -20.0:
		current_volume += step
		player.volume_db = current_volume
		await get_tree().create_timer(duration / ((0 - current_volume) / step)).timeout

func set_battle_music(new_battle_music):
	battleMusic = new_battle_music
	
func set_main_music(new_main_music):
	mainMusic = new_main_music
