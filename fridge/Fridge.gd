extends Position2D
var meats_avaiable:int = 0
var progressBar:ProgressBar
var rechargeButton:Button
var meats_to_add:int = 5
var max_meats:int = 200
signal fridge_full
signal fridge_empty
signal click_on_fridge
signal meat_value_changed
func _ready():
	progressBar = $ProgressBar
	rechargeButton = $Button
	rechargeButton.visible = false
	pass


func _on_Button_button_down():
	progressBar.visible = true
	progressBar.start(0.10,5)
	rechargeButton.visible = false
	pass # Replace with function body.


func _on_ProgressBar_bar_filled():
	progressBar.visible = false
	rechargeButton.visible = true
	if meats_avaiable < max_meats:
		meats_avaiable = meats_avaiable + meats_to_add
		emit_signal("meat_value_changed",meats_avaiable)
	elif meats_avaiable >= max_meats:
		emit_signal("fridge_full",meats_avaiable)
		
	pass # Replace with function body.



func _on_Fridge_click_on_fridge():
	rechargeButton.visible = !rechargeButton.visible
	pass # Replace with function body.


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.is_action_pressed("ui_click"):
			emit_signal("click_on_fridge")

	pass # Replace with function body.

func get_meats(var value:int):
	
	if meats_avaiable > 0:
		meats_avaiable = meats_avaiable + value
		emit_signal("meat_value_changed",meats_avaiable)
	elif meats_avaiable == 0:
		emit_signal("fridge_empty")
	return meats_avaiable
