extends Node3D

const MPLAYER = preload("res://characters/menu character/menu_character.tscn")

func _ready():
	var new_player = MPLAYER.instantiate()
	add_child(new_player)


func _on_server_ip_text_submitted(new_text):
	globals.joining_server_ip = new_text
	$ServerIP.text = ""
	$ServerIP.visible = false
	$"Join".visible = true

func change_level(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)


func _on_ui_test_host_pressed():
	globals.host = true
	globals.hosting_ip = IP.get_local_addresses()[1]
	get_tree().change_scene_to_file("res://main/main.tscn")


func _on_ui_test_join_pressed():
	globals.host = false
	
	get_tree().change_scene_to_file("res://main/main.tscn")
