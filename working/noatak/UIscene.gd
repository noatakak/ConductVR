extends VBoxContainer

signal host_pressed()
signal join_pressed()

var textBox

# Called when the node enters the scene tree for the first time.
func _ready():
	textBox = $Header/test
	Input.connect("key_pressed", self._on_key_pressed)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_key_pressed(event):
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		textBox.set_text(keycode)


func _on_host_pressed():
	emit_signal("host_pressed")


func _on_join_pressed():
	emit_signal("join_pressed")
