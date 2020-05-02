tool
extends Node2D
var items_v = 10
var items_h = 10
var backpack = []

#func _process(delta):
	#for x in range(0,items_v):
	#	for y in range(0,items_h):
	#		get_child(pos_to_index(y,x)).get_child(0).set_text(str(backpack[x][y]))

func _ready():
	get_parent().get_node("grid").set_size(Vector2(items_v*64,items_h*64))
	get_parent().get_node("grid").set_position(Vector2(items_v*64*-0.5,items_h*64*-0.5))
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
			var label = Label.new()
			button.add_child(label)
			if backpack[x][y] == null and not x == items_v-1 and not y == items_h-1:
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
			button.set_scale(Vector2(1,1))
			button.size = Vector2(1,1)
			process_filled_up_grids(button.index,button.size,true)
		2:
			button.texture_normal = load("res://icon.png")
			button.set_scale(Vector2(2,2))
			button.size = Vector2(2,2)
			process_filled_up_grids(button.index,button.size,true)
		3:
			button.texture_normal = load("res://icon.png")
			button.set_scale(Vector2(1,2))
			button.size = Vector2(1,2)
			process_filled_up_grids(button.index,button.size,true)
		4:
			button.texture_normal = load("res://icon.png")
			button.set_scale(Vector2(2,1))
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
		if not x+size.x > items_v and not y+size.y > items_h:
			for a in range(x,x+size.x):
				for b in range(y,y+size.y):
					backpack[a][b] = index
	else:
		if not x+size.x > items_v and not y+size.y > items_h:
			for a in range(x,x+size.x):
				for b in range(y,y+size.y):
					backpack[a][b] = null
					print(a, " " ,b, " ", index)

func check_override(index,m_size):
	var check = 0
	var x = index_to_pos(index).x
	var y = index_to_pos(index).y
	if not x+m_size.x > items_v and not y+m_size.y > items_h:
		for a in range(x,x+m_size.x):
			for b in range(y,y+m_size.y):
				if backpack[a][b] == null:
					check += 1
	#print(m_size.x * m_size.y, " " , check)
	if (m_size.x * m_size.y) <= check:
		return true
		print('return')
	else:
		return false

func on_button_down(index,size):
	#print(index, "  " ,size)
	var select
	if not backpack[index_to_pos(index).x][index_to_pos(index).y] == null:
		select = get_child(backpack[index_to_pos(index).x][index_to_pos(index).y])
	if get_parent().get_node("MouseCurso").texture == null and not select == null:
		get_parent().get_node("MouseCurso").size = select.size
		get_parent().get_node("MouseCurso").set_scale(select.size)
		get_parent().get_node("MouseCurso").texture = select.texture_normal
		get_parent().get_node("MouseCurso").modulate = select.modulate
		select.texture_normal = null
		#print(get_child(index).size)
		process_filled_up_grids(backpack[index_to_pos(index).x][index_to_pos(index).y],select.size,false)

func on_button_up(index,size):
#	print(index)
	var m_size = get_parent().get_node("MouseCurso").size
	if not get_parent().get_node("MouseCurso").texture == null and check_override(index,m_size):
		get_child(index).texture_normal = get_parent().get_node("MouseCurso").texture
		get_child(index).size = m_size
		get_child(index).set_scale(m_size)
		get_child(index).modulate = get_parent().get_node("MouseCurso").modulate
		get_parent().get_node("MouseCurso").texture = null
		#print(index,m_size)
		process_filled_up_grids(index,m_size,true)
