extends Control

var scorePath = "res://Scores/"
var files = []
var dir
var index

signal exit
signal play
signal pause
signal restart


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_score():
	print(Globals.currentPiece)
	scorePath = "res://Scores/" + Globals.currentPiece
	print(scorePath)
	
	_create_file_dir(scorePath)
	
	$PageContainer/Page2.texture = files[0]
	$PageContainer/Page1.texture = files[1]
	index = 1
	print(files.size())
	scorePath = ""
	Globals.currentPiece = ""
	$AudioControlContainer/Play.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.newScore:
		set_score()
	Globals.newScore = false


# Function to create array out of images in folders
func _create_file_dir(path):
	dir = DirAccess.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		elif file_name.contains(".import"):
			file_name = file_name.replace(".import", "")
		#elif !file_name.begins_with(".") and !file_name.ends_with(".import") and !file_name.ends_with(".mid"):
			files.append(ResourceLoader.load(path + "/" + file_name))
		elif file_name.contains(".mid"):
			Globals.currentMidi = path + "/" + file_name
	dir.list_dir_end()


func _on_exit_pressed():
	Globals.currentPiece = ""
	files = []
	emit_signal("exit")
	#get_tree().change_scene_to_file("res://ui/Podium/Podium Menu.tscn")


func _on_prev_page_pressed():
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.start()
	$PageContainer/PrevButtonContainer/PrevButton.disabled = true
	
	if index == 0 || index == 1:
		pass
	elif index % 2 == 0:
		$PageContainer/Page1.texture = files[index - 1]
		index -= 1
		$PageContainer/Page2.texture = files[index - 1]
		index -= 1
		
		print(index)
	else:
		$PageContainer/Page1.texture = files[index - 2]
		index -= 1
		$PageContainer/Page2.texture = files[index - 2]
		index -= 1
		
		print(index)
		
	await timer.timeout
	$PageContainer/PrevButtonContainer/PrevButton.disabled = false


func _on_next_page_pressed():
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.start()
	$PageContainer/NextButtonContainer/NextButton.disabled = true
	
	if index == (files.size() - 1):
		pass
	elif files.size() % 2 == 0:
		$PageContainer/Page1.texture = files[index + 1]
		index += 1
		
		$PageContainer/Page2.texture = files[index + 1]
		index += 1
		
		print(index)
	else:
		$PageContainer/Page1.texture = files[index + 1]
		index += 1
		
		if index <= files.size() - 2:
			$PageContainer/Page2.texture = files[index + 1]
			index += 1
			
			print(index)
		else:
			$PageContainer/Page2.texture = null
			
			print(index)
	await timer.timeout
	$PageContainer/NextButtonContainer/NextButton.disabled = false


func _on_play_pressed():
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.start()
	$AudioControlContainer/Play.disabled = true
	emit_signal("play")
	await timer.timeout
	$AudioControlContainer/Play.disabled = false


func _on_pause_pressed():
	emit_signal("pause")


func _on_restart_pressed():
	emit_signal("restart")
