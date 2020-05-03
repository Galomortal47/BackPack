extends Node2D

export var path = ""
export var mult = false

func _on_Timer_timeout():
	var pos_count = get_node('pos').get_child_count()
	for i in range(0,pos_count):
		if get_node('pos').get_child(i).get_child_count() == 0 or mult:
			var instance = load(path).instance()
			get_node('pos').get_child(i).add_child(instance)
	pass # Replace with function body.
