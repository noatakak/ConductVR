extends VBoxContainer

signal host_pressed()
signal join_pressed()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_host_pressed():
	emit_signal("host_pressed")


func _on_join_pressed():
	emit_signal("join_pressed")
