extends Camera2D

export var camera_shake_min = 0
export var camera_shake_max = 0
export var timer = 0.0
export var smooth = 0.9
export var off_set_max = 135
var time = timer
var start
var shake = false
var current_offset = Vector2(0, 0)


func _process(delta):
	if shake == true:
			self.set_offset(Vector2(rand_range(camera_shake_min, camera_shake_max),rand_range(camera_shake_min, camera_shake_max)))
			time -= delta
	if time < 0:
		shake = false
		reset()
	if Input.is_action_pressed("ui_up"):
		if self.get_offset().y > -off_set_max:
			self.set_offset(Vector2(0,(self.get_offset().y - 10)))
		else:
			self.set_offset(Vector2(0,(-135)))
	elif self.get_offset().y < 0:
		reset()

func reset():
	current_offset = self.get_offset()
	current_offset.x = current_offset.x *smooth
	current_offset.y = current_offset.y *smooth
	self.set_offset(current_offset)

func shake_cam():
	shake = true
	time = timer