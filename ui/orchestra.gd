extends Node3D

@export var midiplayer: MidiPlayer

signal changed_time_sig


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_v_podium_menu_transition_to_score():
	print("3d signal received, menu switched")
	$VPodiumMenu.visible = false
	$ViewScoreMenu.visible = true
	midiplayer.file = Globals.currentMidi

func _on_view_score_menu_score_exit():
	$ViewScoreMenu.visible = false
	$VPodiumMenu.visible = true
	Globals.resetScore = true
	Globals.currentPiece = ""
	Globals.currentMidi = ""
	midiplayer.stop()
	$IctuseManager_right.visible = false
	$IctuseManager_right/AnimationPlayer.stop(true)
	
	$IctuseManager_left.visible = false
	$IctuseManager_left/AnimationPlayer.stop(true)


func _on_music_paused():
	midiplayer.stop()
	$IctuseManager_right.visible = false
	$IctuseManager_right/AnimationPlayer.stop(true)
	
	$IctuseManager_left.visible = false
	$IctuseManager_left/AnimationPlayer.stop(true)


func _on_music_play():
	midiplayer.stop()
	midiplayer.send_reset()
	midiplayer.file = Globals.currentMidi
	midiplayer.play()
	$IctuseManager_right.visible = true
	$IctuseManager_left.visible = true



func _on_music_restart():
	midiplayer.stop()
	$IctuseManager_right.visible = false
	$IctuseManager_right/AnimationPlayer.stop(true)
	
	$IctuseManager_right.visible = false
	$IctuseManager_right/AnimationPlayer.stop(true)


func _on_midi_player_midi_event(channel, event):
	Globals.current_tempo = midiplayer.tempo
	if "args" in event and "type" in event.args and event.args["type"] == 88:
		Globals.beat_pattern = event.args["numerator"]
		emit_signal("changed_time_sig")
	var seconds_per_measure = Globals.beat_pattern/(Globals.current_tempo/60.0)
	var anim_length = $IctuseManager_right/AnimationPlayer.current_animation_length
	$IctuseManager_right/AnimationPlayer.speed_scale = anim_length/seconds_per_measure
	$IctuseManager_left/AnimationPlayer.speed_scale = anim_length/seconds_per_measure
