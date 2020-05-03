extends RayCast2D

var rand = true
var size = Vector2()
onready var icon = load('res://Item/texts/icon2.png')
var color = Color()
var pick = true

func _physics_process(delta):
	if is_colliding():
		if get_collider().is_in_group('player') and Input.is_action_pressed("ui_x") and pick:
			var node = get_collider().get_node('CamShake/BackPack/Inventory/GridContainer')
			if rand:
				node.spawn_item(random_size(),icon,random_color())
			else:
				node.spawn_item(size,icon,color)
			queue_free()

func random_size():
	return Vector2(int(rand_range(1,5)),int(rand_range(1,5)))

func random_color():
	return Color(rand_range(0,1),rand_range(0,1),rand_range(0,1),1)

func _on_Timer_timeout():
	pick = true
	pass # Replace with function body.
