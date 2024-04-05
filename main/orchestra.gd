extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_v_podium_menu_transition_to_score():
	$VPodiumMenu.visible = false
	$ViewScoreMenu.visible = true

func _on_view_score_menu_score_exit():
	$ViewScoreMenu.visible = false
	$VPodiumMenu.visible = true
