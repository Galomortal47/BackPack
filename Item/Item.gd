extends RayCast2D

func _physics_process(delta):
	if is_colliding():
		if get_collider().is_in_group('player'):
			get_collider().get_node('CamShake/BackPack/Inventory/GridContainer')
			queue_free()