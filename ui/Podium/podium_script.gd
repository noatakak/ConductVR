extends Node3D

signal transition_to_score()

func on_score_selected():
	emit_signal("transition_to_score")

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = $MeshInstance3D/Viewport2Din3D.get_scene_instance()
	if scene:
		scene.connect("score_selected", on_score_selected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
