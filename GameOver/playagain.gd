extends Button

export var next = ""

func _on_play_again_button_down():
	get_tree().change_scene(next)
	pass # Replace with function body.
