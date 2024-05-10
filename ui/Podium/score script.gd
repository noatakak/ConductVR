extends Node3D

signal score_exit()
signal music_play()
signal music_paused()
signal music_restart()

func on_exit_pressed():
	emit_signal("score_exit")

func on_play_pressed():
	emit_signal("music_play")

func on_pause_pressed():
	emit_signal("music_paused")
	
func on_restart_pressed():
	emit_signal("music_restart")


# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = $MeshInstance3D/Viewport2Din3D.get_scene_instance()
	if scene:
		scene.connect("exit", on_exit_pressed)
		scene.connect("play", on_play_pressed)
		scene.connect("pause", on_pause_pressed)
		scene.connect("restart", on_restart_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
