extends Control

signal score_selected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed(extra_arg_0 : String):
	Globals.currentPiece = extra_arg_0
	emit_signal("score_selected")
	#get_tree().change_scene_to_file("res://ui/Podium/Score Menu.tscn")
