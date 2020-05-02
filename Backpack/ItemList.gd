tool
extends ItemList
var items_v = 15
var items_h = 8

func _ready():
	max_columns = items_h
	rect_min_size = Vector2(items_v * 30, items_h * 10)
	for i in range(0,items_v * items_h):
		add_item('item')
	pass # Replace with function body.