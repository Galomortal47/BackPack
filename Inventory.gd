tool
extends Node2D
var items_v = 15
var items_h = 8
var backpack = []

func _ready():
	backpack.resize(items_v)
	for i in range(0,items_v):
		backpack[i] = []
		backpack[i].resize(items_h)
	print(backpack)
#	set_columns(items_v)
	set_position(Vector2(items_v*64*-0.5,items_h*64*-0.5))
	for x in range(0,items_v):
		for y in range(0,items_h):
			var button = TextureButton.new()
			button.set_script(load('res://TextureButton.gd'))
			button.set_position(Vector2(x*64,y*64))
			button.index = pos_to_index(y,x)
			#print(button.index)
			button.connect("index_button_down", self, "on_button_down")
			button.connect("index_button_up", self, "on_button_up")
			button.set_size(Vector2(64,64))
			if backpack[x][y] == null:
				test_gen_random_stuff(button)
			add_child(button)
	pass

func test_gen_random_stuff(button):
	randomize()
	button.modulate = Color(rand_range(0,1),rand_range(0,1),rand_range(0,1),1)
	var gen = int(rand_range(0,10))
	match gen:
		1:
			button.texture_normal = load("res://icon.png")
			button.size = Vector2(1,1)
			process_filled_up_grids(button.index,button.size,true)
		2:
			button.texture_normal = load("res://icon_big.png")
			button.size = Vector2(2,2)
			process_filled_up_grids(button.index,button.size,true)
		3:
			button.texture_normal = load("res://icon_h.png")
			button.size = Vector2(1,2)
			process_filled_up_grids(button.index,button.size,true)
		4:
			button.texture_normal = load("res://icon_v.png")
			button.size = Vector2(2,1)
			process_filled_up_grids(button.index,button.size,true)


func pos_to_index(y,x):
	return y + (x*items_h)

func index_to_pos(index):
	var x = int(round(index/items_h))
	var y = fmod(index,items_h)
	return Vector2(x,y)

func process_filled_up_grids(index,size,remove_add):
	var x = index_to_pos(index).x
	var y = index_to_pos(index).y
	var r = pos_to_index(y,x)
	#backpack[x][y] = index
	if remove_add:
		for a in range(x,x+size.x):
			for b in range(y,y+size.y):
				backpack[a][b] = index
				print(a," ",b," ",index)
	else:
		for a in range(x,x+size.x):
			for b in range(y,y+size.y):
				backpack[a][b] = null
	#print(index, "  " ,x, "  " ,y, "  ", r)

func check_override(index):
	return backpack[index_to_pos(index).x][index_to_pos(index).y]

func on_button_down(index,size):
	#print(index, "  " ,size)
	if get_parent().get_node("MouseCurso").texture == null:
		get_parent().get_node("MouseCurso").size = get_child(index).size
		get_parent().get_node("MouseCurso").texture = get_child(index).texture_normal
		get_parent().get_node("MouseCurso").modulate = get_child(index).modulate
		get_child(index).texture_normal = null
		print(get_child(index).size)
		process_filled_up_grids(index,size,false)

func on_button_up(index,size):
#	print(index)
	var m_size = get_parent().get_node("MouseCurso").size
	if not get_parent().get_node("MouseCurso").texture == null and check_override(index) == null:
		get_child(index).texture_normal = get_parent().get_node("MouseCurso").texture
		get_child(index).size = m_size
		get_child(index).modulate = get_parent().get_node("MouseCurso").modulate
		get_parent().get_node("MouseCurso").texture = null
		print(index,m_size)
		process_filled_up_grids(index,m_size,true)
