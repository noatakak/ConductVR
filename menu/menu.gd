extends Node3D

const MPLAYER = preload("res://characters/menu character/menu_character.tscn")
var new_player

func _ready():
	new_player = MPLAYER.instantiate()
	add_child(new_player)

func _process(delta):
	$UITest.global_transform.origin = new_player.find_child("UI_marker").global_transform.origin
	$UITest.look_at(new_player.find_child("XRCamera3D").global_transform.origin, Vector3(0,1,0), true)

func _on_server_ip_text_submitted(new_text):
	Globals.joining_server_ip = new_text
	$ServerIP.text = ""
	$ServerIP.visible = false
	$"Join".visible = true


func _on_ui_test_host_pressed():
	Globals.host = true
	Globals.hosting_ip = IP.get_local_addresses()[1]
	get_tree().change_scene_to_file("res://main/main.tscn")


func _on_ui_test_join_pressed():
	Globals.host = false
	
	get_tree().change_scene_to_file("res://main/main.tscn")
