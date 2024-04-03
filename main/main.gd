extends Node3D

const PLAYER = preload("res://characters/player character/player_character.tscn")
const PORT = 9999

var enet_peer = ENetMultiplayerPeer.new()

var ip_array = IP.get_local_addresses()
var ips = " ".join(ip_array)
var ip_address



func _ready():
	if Globals.host == true:
		$Label3D.text = Globals.hosting_ip
		_hosting()
	else:
		$Label3D.text = Globals.joining_server_ip
		_joining()


func _hosting():
	# Start as a server
	enet_peer.create_server(PORT)
	if enet_peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = enet_peer
	
	#IPs
	print("IP addresses in array: " + ips)
	
	# Windows IP
	if OS.has_feature("windows"):
		if OS.has_environment("COMPUTERNAME"):
			ip_address = IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")), 1)
	
	# Linux IP
	elif OS.has_feature("linux"):
		if OS.has_environment("HOSTNAME"):
			ip_address = IP.resolve_hostname(str(OS.get_environment("HOSTNAME")), 1)
	
	# Mac IP
	elif OS.has_feature("macos"):
		if OS.has_environment("HOSTNAME"):
			ip_address = IP.resolve_hostname(str(OS.get_environment("HOSTNAME")), 1)
	
	# Android IP
	elif OS.has_feature("android"):
		if OS.has_environment("HOSTNAME"):
			ip_address = IP.resolve_hostname(str(OS.get_environment("HOSTNAME")), 1)
	
	ip_address = ip_array[1]
	Globals.hosting_ip = ip_address
	
	print("IP address (most likely): " + ip_address)
	
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)
	
	add_player()


func _joining():
	# Start as client
	enet_peer.create_client(Globals.joining_server_ip, PORT)
	multiplayer.multiplayer_peer = enet_peer


func _exit_tree():
	if not multiplayer.is_server():
		return
	
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.disconnect(del_player)


func add_player(id = 1):
	var character = PLAYER.instantiate()
	character.name = str(id)
	$Players.add_child(character)


func del_player(id):
	if not $Players.has_node(str(id)):
		return
	$Players.get_node(str(id)).queue_free()


# The server can restart the level by pressing HOME
func _input(event):
	if not multiplayer.is_server():
		return
	if event.is_action("ui_home") and Input.is_action_just_pressed("ui_home"):
		get_tree().change_scene_to_file("res://main/main.tscn")
