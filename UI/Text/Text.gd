extends Position2D
export (Color,RGBA) var no_color
export (Color,RGBA) var red
export (Color,RGBA) var yellow
export (Color,RGBA) var gray
var text:Label
var timer:Timer
var max_pos_y:float = -20
var parent
func _ready():
	text = $Text
	timer = $Timer
	parent = get_parent()
	fade()
	pass
func set_color(var color_name:String):
	if color_name == "red":
		text.modulate = red
	elif color_name == "yellow":
		text.modulate = yellow
	elif color_name == "gray":
		text.modulate = gray
	elif color_name == "no":
		text.modulate = no_color
func move(var step_pos:float = 2.5,var step_modulate:float = 0.1):
	step_modulate = -1*(1/float(max_pos_y/step_pos))
	text.modulate.a = text.modulate.a - step_modulate
	text.rect_position.y = text.rect_position.y - step_pos
	var aux:float = (max_pos_y/step_pos)*(-1)
	
	if text.rect_position.y < max_pos_y:
		timer.stop()
		self.queue_free()
		#emit_signal("fade_finished")
func fade():
	timer.start()
func set_text(var txt = "null"):
	text.text = txt
