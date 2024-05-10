extends Control

signal score_selected

var buttons_ready = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.resetScore:
		enable_buttons()


func _on_button_pressed(extra_arg_0 : String):
	disable_buttons()
	buttons_ready = false
	Globals.currentPiece = extra_arg_0
	emit_signal("score_selected")
	Globals.newScore = true
	print("button pressed - first signal sent")
	#get_tree().change_scene_to_file("res://ui/Podium/Score Menu.tscn")


func disable_buttons():
	var list = $VBoxContainer
	list = list.get_children()
	for child in list:
		child.disabled = true
		
func enable_buttons():
	var list = $VBoxContainer
	list = list.get_children()
	for child in list:
		child.disabled = false
	Globals.resetScore = false
