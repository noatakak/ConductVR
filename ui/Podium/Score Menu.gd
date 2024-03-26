extends Control

var scorePath = "res://Scores/"
var files = []
var dir
var index

# Called when the node enters the scene tree for the first time.
func _ready():
	print(Globals.currentPiece)
	scorePath += Globals.currentPiece
	print(scorePath)
	
	_create_file_dir(scorePath)
	
	$PageContainer/Page1.texture = files[0]
	$PageContainer/Page2.texture = files[1]
	index = 1
	print(files.size())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Function to create array out of images in folders
func _create_file_dir(path):
	dir = DirAccess.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		elif !file_name.begins_with(".") and !file_name.ends_with(".import"):
			files.append(load(path + "/" + file_name))
	dir.list_dir_end()


func _on_exit_pressed():
	Globals.currentPiece = ""
	get_tree().change_scene_to_file("res://ui/Podium/Podium Menu.tscn")


func _on_prev_page_pressed():
	if index == 0 || index == 1:
		pass
	else:
		$PageContainer/Page2.texture = files[index - 1]
		index -= 1
		$PageContainer/Page1.texture = files[index - 1]
		index -= 1


func _on_next_page_pressed():
	if index == (files.size() - 2):
		pass
	else:
		$PageContainer/Page1.texture = files[index + 1]
		index += 1
		$PageContainer/Page2.texture = files[index + 1]
		index += 1
