extends Sprite

var size

func _process(delta):
	set_global_position(get_global_mouse_position())
