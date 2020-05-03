extends RayCast2D

var rand = true
var size = Vector2()
var icon = ''
var color = Color()
var pick = true

func _ready():
	if rand:
		color = random_color()
		size = random_size()
		icon = random_icon()
	get_node('Sprite').texture = icon
	get_node('Sprite').self_modulate = color
	get_node('Sprite').set_scale(size*0.25)

func _physics_process(delta):
	if is_colliding():
		if get_collider().is_in_group('player') and Input.is_action_pressed("ui_x") and pick:
			var node = get_collider().get_node('CamShake/BackPack/Inventory/GridContainer')
			node.spawn_item(size,icon,color)
			queue_free()

func random_size():
	return Vector2(round(rand_range(1,3)),round(rand_range(1,3)))

func random_color():
	return Color(rand_range(0,1),rand_range(0,1),rand_range(0,1),1)

func random_icon():
	var data = load('res://Item/texts/icon' + str(round(rand_range(1,10))) + '.png')
	return data

func _on_Timer_timeout():
	pick = true
	pass # Replace with function body.
