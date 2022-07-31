extends Position2D
onready var nodeFridge = get_node("../../../Restaurant/Furniture/Fridge")
var timer:Timer
var interactMenu:Position2D
var area:Area2D
var grillBody:Position2D
var progressBar:ProgressBar
var characterHolder:Position2D
enum states {IDLE,FILING,RAW_MEAT_ON,COOKING,COOKED_MEAT_ON,TOSTED_MEAT_ON,DIRTY,CLEANING}
var state = states.IDLE
export (Color,RGBA) var selected_color
export (Color,RGBA) var not_selected_color
export (Color,RGBA) var red
export (Color,RGBA) var yellow
signal state_changed
var aux_meats = 0
var meats:int = 0
var meats_cooked:int = 0
var meats_tosted:int = 0
var max_meat:int = 5
var turn:int = 0
var turn_max:int = 5
signal meats_variables_changed
func _ready():
	timer = $Timer
	interactMenu = $InteractMenu
	grillBody = $GrillBody
	progressBar = $ProgressBar
	characterHolder = $CharacterHolder
func _process(delta):
	
	pass
	#print(state)
"""------Progress Bar signals------"""
func _on_ProgressBar_bar_filled():
	if state == states.FILING:
		state = states.RAW_MEAT_ON
		emit_signal("state_changed")
	elif state == states.COOKING:
		state = states.COOKED_MEAT_ON
		emit_signal("state_changed")
		interactMenu.visible = true
		
		
		progressBar.start(0.10,5) # time to remove
		progressBar.visible = true
	elif state == states.COOKED_MEAT_ON:
		if meats > 0:
			state = states.TOSTED_MEAT_ON
			emit_signal("state_changed")
		elif meats == 0:
			state = states.IDLE
			emit_signal("state_changed")
			progressBar.visible = false
	elif state == states.CLEANING:
		progressBar.visible = false
		state = states.IDLE
		emit_signal("state_changed")
"""-----Interact Menu signals------"""
func _on_InteractMenu_button_meat_down():
	if state == states.IDLE:
		if meats < max_meat && nodeFridge.meats_avaiable > 0:
			progressBar.text.visible = true
			progressBar.to_step(100/max_meat)
			meats = meats + 1
			nodeFridge.get_meats(-1)
			emit_signal("meats_variables_changed",meats_cooked,meats_tosted)
			progressBar.text.text = str(meats)+"/"+ str(max_meat)
			state = states.FILING
			emit_signal("state_changed")
		elif nodeFridge.meats_avaiable == 0:
			nodeFridge.get_meats(-1)
			
			
	elif state == states.FILING:
		if meats < max_meat  && nodeFridge.meats_avaiable > 0:
				meats = meats + 1
				nodeFridge.get_meats(-1)
				emit_signal("meats_variables_changed",meats_cooked,meats_tosted)
				progressBar.to_step(100/max_meat)
		elif nodeFridge.meats_avaiable == 0:
			nodeFridge.get_meats(-1)
		elif meats == max_meat:
			state = states.RAW_MEAT_ON
			emit_signal("state_changed")
		progressBar.text.text = str(meats)+"/"+ str(max_meat)
	elif state == states.COOKED_MEAT_ON:
		if meats > 0:
			meats = meats - 1
			meats_cooked = meats_cooked + 1
			emit_signal("meats_variables_changed",meats_cooked,meats_tosted)
			progressBar.text.text = str(meats)+"/"+ str(max_meat)
			progressBar.visible = true
			if meats == 0:
				progressBar.stop()
				progressBar.visible = false
				turn = turn + 1
				state = states.IDLE
				emit_signal("state_changed")
			
		
	elif state == states.TOSTED_MEAT_ON:
		meats = meats - 1
		meats_tosted = meats_tosted + 1
		emit_signal("meats_variables_changed",meats_cooked,meats_tosted)
		progressBar.text.text = str(meats)+"/"+ str(max_meat)
		progressBar.to_step(100/aux_meats)
		if meats == 0:
			progressBar.visible = false
			state = states.DIRTY
			emit_signal("state_changed")



		
func _on_InteractMenu_button_cook_down():
	aux_meats = meats
	if state == states.RAW_MEAT_ON:
		progressBar.start(0.10,5)
		state = states.COOKING
		emit_signal("state_changed")
	elif state == states.FILING:
		state = states.COOKING
		emit_signal("state_changed")
		progressBar.start(0.10,5)
		pass
func _on_InteractMenu_button_clear_down():
	if state == states.DIRTY:
		state = states.CLEANING
		emit_signal("state_changed")
		progressBar.text.visible = false
		progressBar.start(0.10,5)
func _on_InteractMenu_button_cancel_down():
	pass # Replace with function body.






func _on_Area2D_body_entered(body):
	print(body.name)
	pass # Replace with function body.
