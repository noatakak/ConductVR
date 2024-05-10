extends Node3D

var tempo: float
var beat_pattern: int
var seconds_per_measure: float


# Called when the node enters the scene tree for the first time.
func _ready():
	tempo = Globals.current_tempo
	beat_pattern = Globals.beat_pattern
	seconds_per_measure = beat_pattern/(tempo/60.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tempo = Globals.current_tempo
	beat_pattern = Globals.beat_pattern
	seconds_per_measure = beat_pattern/(tempo/60.0)


func _on_orchestra_changed_time_sig():	
	tempo = Globals.current_tempo
	beat_pattern = Globals.beat_pattern
	seconds_per_measure = beat_pattern/(tempo/60.0)
	var anim_time = seconds_per_measure / $AnimationPlayer.get_animation( "beat_anims/"+ str(beat_pattern) + "_pattern").length
	print(anim_time)
	$AnimationPlayer.play("beat_anims/"+ str(beat_pattern) + "_pattern")
	
