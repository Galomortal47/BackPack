extends Sprite

var size
var follow = true

func _ready():
	hide()

func _physics_process(delta):
	if Input.is_action_just_pressed("mouse_right"):
		set_global_position(get_global_mouse_position())
		follow = false
		show()
	if follow:
		set_global_position(get_global_mouse_position())

func _on_Drop_button_down():
	follow = true
	hide()
	pass # Replace with function body.

func _on_Use_button_down():
	follow = true
	hide()
	pass # Replace with function body.
