extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ui_test_host_pressed():
	Network._on_host_pressed($PlayerNode)


func _on_ui_test_join_pressed():
	Network._on_join_pressed($PlayerNode)
