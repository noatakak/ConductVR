extends Node

# Variables
@export var server_ip: String

const PORT = 9999
var player

var connected_peer_ids = []
var local_player_character
var enet_peer = ENetMultiplayerPeer.new()

var ip_array = IP.get_local_addresses()
var ips = " ".join(ip_array)

var ip_address

# Unused variable for UPNP.
var external_ip


# Detects if text has been submitted for joining IP address,
# assigns the correct variables, and then deals with menus.
func _on_server_ip_text_submitted(new_text):
	server_ip = new_text
#	$ServerIP.text = ""
#	$ServerIP.visible = false
#	$ServerIP.visible = true


# On pressing host button, creates server, figures out joining address,
# which is just the local IP right now, and calls function to add host
# character
func _on_host_pressed(playerNode):
	player = playerNode
	# Menu visiblity and text
#	$NetworkInfo/NetworkSideDisplay.text = "Server Side"
#	$Menu.visible = false
#	$ServerIP.visible = false
	
	# Creating server and player lists
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	
	add_player(multiplayer.get_unique_id())
	
	# IP
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
	
	print("IP address is most likely: " + "10.72.42.84")
	
	# Will remain commented out as identifier of what we tried before.
	# upnp_setup()


# Calls functions and deals with menus when pressing join.
func _on_join_pressed(playerNode):
	player=playerNode
#	$NetworkInfo/NetworkSideDisplay.text = "Client Side"
#	$Menu.visible = false
#	$ServerIP.visible = false
	
	enet_peer.create_client(server_ip, PORT)
	multiplayer.multiplayer_peer = enet_peer


# Function to add player characters.
func add_player(peer_id):
	player.name = str(peer_id)
	add_child(player)


# Function to remove player characters.
func remove_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		player.queue_free()


# Function for chat messages (probably not going to be used)
func _on_message_input_text_submitted(new_text):
	local_player_character.rpc("display_message", new_text)
#	$MessageInput.text = ""
#	$MessageInput.release_focus()


# DO NOT USE: this is simply for showing what we tried,
# this is a major computer security hazard.
func upnp_setup():
	var upnp = UPNP.new()
	var discover_result = upnp.discover()
	assert(discover_result == UPNP.UPNP_RESULT_SUCCESS, \
	"UPNP Invalid Gateway!")
	
	if discover_result == UPNP.UPNP_RESULT_SUCCESS:
		if upnp.get_gateway() and upnp.get_gateway().is_valid_gateway():
			var map_result_udp = upnp.add_port_mapping(PORT, 0, "godot_udp", "UDP", 0)
			var map_result_tcp = upnp.add_port_mapping(PORT, 0, "godot_tcp", "TCP", 0)
			
			if not map_result_udp == UPNP.UPNP_RESULT_SUCCESS:
				upnp.add_port_mapping(PORT, 0, "", "UDP")
			if not map_result_tcp == UPNP.UPNP_RESULT_SUCCESS:
				upnp.add_port_mapping(PORT, 0, "", "TCP")
	
	external_ip = upnp.query_external_address()
	
	print("Success! Join address is: %s" % upnp.query_external_address())
