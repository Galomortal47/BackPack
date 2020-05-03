extends Label

func _ready():
	set_text(str(get_node('/root/singleton').score))
	pass # Replace with function body.
