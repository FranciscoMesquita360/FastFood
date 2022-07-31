extends Position2D
var clam_open:Sprite
var clam_closed:Sprite
var meat:Sprite
var grill
var grill_board:Sprite
var pos_aux
export (Color,RGBA) var not_selected_color
export (Color,RGBA) var selected_color
var meat_cooked = load("res://grill/GrillBody/Meat/meat_cooked.png")
var meat_raw = load("res://grill/GrillBody/Meat/meat_raw.png")
var meat_tosted = load("res://grill/GrillBody/Meat/meat_tosted.png")
var board_dirty = load("res://grill/GrillBody/grill_board_dirty.png")
var board_clear = load("res://grill/GrillBody/grill_board_clear.png")
signal click_on_grill_body
func _ready():
	grill_board = $grill_board
	clam_open = $clam_open
	clam_closed = $clam_closed
	pos_aux  = clam_closed.position
	meat = $meat
	grill = get_parent()
	pass

func _on_Grill_state_changed():
	if grill.state == grill.states.IDLE:
		grill_board.texture = board_clear
		meat.visible = false
		toglle_clam("open")
	elif grill.state == grill.states.RAW_MEAT_ON:
		meat.visible = true
		meat.texture = meat_raw
	elif grill.state == grill.states.COOKING:
		toglle_clam("closed")
	elif grill.state == grill.states.COOKED_MEAT_ON:
		meat.visible = true
		meat.texture = meat_cooked
		toglle_clam("open")
	elif grill.state == grill.states.TOSTED_MEAT_ON:
		meat.visible = true
		meat.texture = meat_tosted
	elif grill.state == grill.states.DIRTY:
		meat.visible = false
		meat.texture = meat_raw
		grill_board.texture = board_dirty

		





func fill_plate():
		meat.texture = meat_raw
		meat.visible = true

func _on_ProgressBar_value_changed(value):
	if grill.state == grill.states.COOKING:
		if value > 8 && value < 18:
			clam_closed.position.y = clam_closed.position.y + 0.5
		elif value > 90 && value < 100:
			clam_closed.position.y = clam_closed.position.y - 0.5
		elif value == 100:
			clam_closed.position = pos_aux
			pass


func toglle_clam(var value:String):
	if value == "closed":
		clam_closed.visible = true
		clam_open.visible = false
	elif value == "open":
		clam_closed.visible = false
		clam_open.visible = true

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.is_action_pressed("ui_click"):
			emit_signal("click_on_grill_body")


func _on_Area2D_body_entered(body):
	print("entrou")
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	print("saiu")
	pass # Replace with function body.
