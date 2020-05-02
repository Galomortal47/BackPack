tool
extends TextureButton

signal index_button_down(index,size)
signal index_button_up(index,size)
var index = 0
var size = Vector2(1,1)

func _ready():
	connect("button_down", self, "_on_TextureButton_button_down")
	connect("mouse_entered", self, "_on_TextureButton_button_up")

func _on_TextureButton_button_down():
	emit_signal("index_button_down",index,size)
	pass # Replace with function body.

func _on_TextureButton_button_up():
	emit_signal("index_button_up",index,size)
	pass # Replace with function body.
