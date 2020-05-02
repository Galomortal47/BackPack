extends RayCast2D

func _physics_process(delta):
	if is_colliding():
		if get_collider().is_in_group('player'):
			var node = get_collider().get_node('CamShake/BackPack/Inventory/GridContainer')
			node.spawn_item(Vector2(2,2),'icon2',Color(1,0,1,1))
			queue_free()