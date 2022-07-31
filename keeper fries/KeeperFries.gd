extends Position2D
signal click_on
signal fries_value_changed
var progressBar:ProgressBar
var fries
enum states {IDLE,TAKING_FRIES}
var state = states.IDLE
var index 
var value
func _ready():
	progressBar = $ProgressBar
	fries = $keeper_fries/fries_grid_vertical.get_children()
	index = fries.size()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.is_action_pressed("ui_click"):
			emit_signal("click_on")



func _on_KeeperFries_click_on():
	if index>0&& state == states.IDLE:
		state = states.TAKING_FRIES
		progressBar.visible = true
		progressBar.start(0.10,30)
	pass # Replace with function body.


func _on_ProgressBar_bar_filled():
	if index>0 :
		fries[index-1].visible = false
		index = index - 1
		emit_signal("fries_value_changed",index)
		state = states.IDLE

func fill():
	for i in fries.size():
		fries[i].visible = true
		index = fries.size() 
		emit_signal("fries_value_changed",index)

func _on_KeeperFries_visibility_changed():
	emit_signal("fries_value_changed",index)
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	print("entrou")
	pass # Replace with function body.
