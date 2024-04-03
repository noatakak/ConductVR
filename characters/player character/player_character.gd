extends XROrigin3D

@export var left_hand_marker: Marker3D
@export var right_hand_marker: Marker3D

@export var camera: XRCamera3D

@export var head_tracker: Node3D
@export var left_hand_tracker: OpenXRHand
@export var right_hand_tracker: OpenXRHand

@export var char_node: Node3D

var offset = Vector3(0, 0, -0.15)


func _enter_tree():
	set_multiplayer_authority(str(name).to_int())
	Globals.playerID = str(name)
	
func _server_closed():
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func _ready():
	if not is_multiplayer_authority(): return
	multiplayer.server_disconnected.connect(_server_closed)
	$XRCamera3D/Label3D.text = Globals.playerID

func _process(_delta):
	if not is_multiplayer_authority(): return
	update_body_position_and_rotation()
	
func update_body_position_and_rotation():
	left_hand_marker.global_position = left_hand_tracker.global_position
	right_hand_marker.global_position = right_hand_tracker.global_position
	
	var target_pos = camera.global_transform.origin
	head_tracker.global_transform.origin = target_pos - camera.global_transform.basis.z * offset.z
	char_node.global_transform.origin = head_tracker.global_transform.origin + Vector3(0, -1.7, 0);
	char_node.global_rotation.y = head_tracker.global_rotation.y + PI



