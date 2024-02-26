extends XROrigin3D


func _enter_tree():
	set_multiplayer_authority(str(name).to_int())
	globals.playerID = str(name)
	
func _server_closed():
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func _ready():
	if not is_multiplayer_authority(): return
	multiplayer.server_disconnected.connect(_server_closed)
	$XRCamera3D/Label3D.text = globals.playerID

func _process(_delta):
	if not is_multiplayer_authority(): return
