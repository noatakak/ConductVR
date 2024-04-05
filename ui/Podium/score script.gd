extends Node3D

signal score_exit()

func on_exit_pressed():
	emit_signal("score_exit")


# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = $MeshInstance3D/Viewport2Din3D.get_scene_instance()
	if scene:
		scene.connect("exit", on_exit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
