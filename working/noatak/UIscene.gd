extends VBoxContainer

signal host_pressed()
signal join_pressed()

var textBox

# Called when the node enters the scene tree for the first time.
func _ready():
	textBox = $TextBox/LineEdit
	$IPContainer/Label.set_text("Your IP address is: " + str(Network.ips[1]))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		print(keycode)
		if keycode == KEY_BACKSPACE:  # Backspace key
			textBox.text = textBox.get_text().left(textBox.get_text().length() - 1)
		elif keycode in range(32, 127):  # ASCII printable characters
			var character = char(keycode)
			print(character)
			textBox.text = textBox.get_text() + character
			print(Network)
			Network.server_ip = textBox.get_text()


func _on_host_pressed():
	emit_signal("host_pressed")


func _on_join_pressed():
	emit_signal("join_pressed")
