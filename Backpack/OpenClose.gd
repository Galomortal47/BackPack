extends Node2D

var start = true

func _physics_process(delta):
	if Input.is_action_pressed("ui_x"):
		get_node("AnimationPlayer").play('Open')
		start = false
	elif not start:
		get_node("AnimationPlayer").play('Clear')