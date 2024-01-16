extends Node3D

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	set_multiplayer_authority(str(name).to_int())


func _ready():
	name = str(get_multiplayer_authority())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
@rpc("unreliable")
func remote_set_position(authority_position):
	global_position = authority_position

func _physics_process(delta):
	if is_multiplayer_authority():
		rpc("remote_set_position", global_position)
