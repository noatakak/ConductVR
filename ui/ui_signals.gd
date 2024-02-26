extends Node3D

signal host_pressed()
signal join_pressed()

func on_host_pressed():
	emit_signal("host_pressed")
	print("pressed")
func on_join_pressed():
	emit_signal("join_pressed")


# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = $MeshInstance3D/Viewport2Din3D.get_scene_instance()
	if scene:
		scene.connect("host_pressed", on_host_pressed)
		scene.connect("join_pressed", on_join_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
