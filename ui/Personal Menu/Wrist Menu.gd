extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$"VBoxContainer/Song Title".text = Globals.currentPiece
	
	# Put something here for how if the player is not the host, "restart"
	# does not show up.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Unsure if we need this, leaving it just in case
func _process(delta):
	pass


# If button is pressed, player microphone would be muted
func _on_mute_pressed():
	pass # Replace with function body.


# If pressed, player would be disconnected and sent back to main menu
func _on_disconnect_pressed():
	pass # Replace with function body.


# Should only be pressable by host, would restart the server in case of weird
# bugs or such.
func _on_restart_pressed():
	pass # Replace with function body.
