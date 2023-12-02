extends XROrigin3D

@export var left_hand_marker: Marker3D
@export var right_hand_marker: Marker3D

@export var camera: XRCamera3D

@export var head_tracker: Node3D
@export var left_hand_tracker: OpenXRHand
@export var right_hand_tracker: OpenXRHand

@export var char_node: Node3D

var offset = Vector3(0, 0, -0.15)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	left_hand_marker.global_position = left_hand_tracker.global_position
	right_hand_marker.global_position = right_hand_tracker.global_position
	
	var target_pos = camera.global_transform.origin
	head_tracker.global_transform.origin = target_pos - camera.global_transform.basis.z * offset.z
	char_node.global_transform.origin = head_tracker.global_transform.origin + Vector3(0, -1.7, 0);
	char_node.global_rotation.y = head_tracker.global_rotation.y + PI
