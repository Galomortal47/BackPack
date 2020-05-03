extends Node2D

export var path = ""
export var mult = false
onready var counter = -1

func _on_Timer_timeout():
	randomize()
	var pos_count = get_node('pos').get_child_count()
	var i
	i = int(rand_range(0,pos_count))
	if get_node('pos').get_child(i).get_child_count() == 0 or mult:
		var instance = load(path).instance()
		get_node('pos').get_child(i).add_child(instance)
		counter += 1
		get_node('CanvasLayer/ScoreInt').set_text(str(counter))
		get_node("Game Over").start()
		get_node("/root/singleton").score = counter
	pass # Replace with function body.

func _physics_process(delta):
	get_node('CanvasLayer/Timeleft').set_text(str(int(get_node("Game Over").time_left)))

func _on_Game_Over_timeout():
	get_tree().change_scene('res://GameOVer.tscn')
	pass # Replace with function body.
