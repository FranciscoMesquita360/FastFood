extends Position2D
signal button_cook_down
signal button_meat_down
signal button_cancel_down
signal button_clear_down
signal button_recharge_down
var grill
export (Color,RGBA) var red
export (Color,RGBA) var yellow
var cooked_meat_icon = load("res://grill/UI/InteractMenu/cooked_meat_icon.png")
var raw_meat_icon = load("res://grill/UI/InteractMenu/raw_meat_icon.png")
var tosted_meat_icon = load("res://grill/UI/InteractMenu/tosted_meat_icon.png")
var recharge_meat_icon
var cookButton:Button
var meatButton:Button
var cancelButton:Button
var clearButton:Button

var text
func _ready():
	grill = get_parent()
	cookButton = $MarginContainer/HBoxContainer/CookButton
	meatButton = $MarginContainer/HBoxContainer/MeatButton
	cancelButton = $MarginContainer/HBoxContainer/CancelButton
	clearButton = $MarginContainer/HBoxContainer/ClearButton

	text = $Text
func _on_CookButton_button_down():
	emit_signal("button_cook_down")
	pass # Replace with function body.


func _on_MeatButton_button_down():
	emit_signal("button_meat_down")
	pass # Replace with function body.

func _on_CancelButton_button_down():
	emit_signal("button_cancel_down")
	pass # Replace with function body.


func _on_ClearButton_button_down():
	emit_signal("button_clear_down")
	pass # Replace with function body.

func _on_Grill_state_changed():
	if grill.state == grill.states.IDLE:
		meatButton.icon = raw_meat_icon
		meatButton.visible = true
		cookButton.visible = false
		cancelButton.visible = false
		clearButton.visible = false
		
	elif grill.state == grill.states.FILING:
		meatButton.icon = raw_meat_icon
		
		cookButton.visible = true
		meatButton.visible = true
		cancelButton.visible = false
		clearButton.visible = false
	elif grill.state == grill.states.RAW_MEAT_ON:
		text.visible = false
		cookButton.visible = true
		meatButton.visible = false
		cancelButton.visible = false
		clearButton.visible = false
	elif grill.state == grill.states.COOKING:
		cookButton.visible = false
		meatButton.visible = false
		text.visible = false
		cancelButton.visible = false
		clearButton.visible = false
	elif grill.state == grill.states.COOKED_MEAT_ON:
		meatButton.icon = cooked_meat_icon
		cookButton.visible = false
		meatButton.visible = true
		cancelButton.visible = false
		clearButton.visible = false
	elif grill.state == grill.states.TOSTED_MEAT_ON:
		meatButton.icon = tosted_meat_icon
		cookButton.visible = false
		meatButton.visible = true
		text.text = str(grill.meats_tosted)
		text.modulate = red
		cancelButton.visible = false
		clearButton.visible = false
	elif grill.state == grill.states.DIRTY:
		text.visible = false
		clearButton.visible = true
		cookButton.visible = false
		meatButton.visible = false
		cancelButton.visible = false
		pass
	elif grill.state == grill.states.CLEANING:
		text.visible = false
		clearButton.visible = false
		cookButton.visible = false
		meatButton.visible = false
		cancelButton.visible = false
		pass



func _on_InteractMenu_visibility_changed():
	_on_Grill_state_changed()
	pass # Replace with function body.



func _on_GrillBody_click_on_grill_body():
	if visible:
		visible = false
	else:
		visible = true


