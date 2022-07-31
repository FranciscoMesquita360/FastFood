extends Position2D
signal click_on_cash
signal value_orders_changed
var progressBar: ProgressBar
var animatedSprite:AnimatedSprite
var orders:int = 0
enum states {IDLE,TAKING_ORDER}
var state = states.IDLE
func _ready():
	progressBar = $ProgressBar
	animatedSprite = $animatedSprite
	

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.is_action_pressed("ui_click") && (state == states.IDLE):
			emit_signal("click_on_cash")



func _on_cash_register_click_on_cash():
	if state == states.IDLE:
		progressBar.start(0.10,10)
		state = states.TAKING_ORDER
	pass # Replace with function body.


func _on_ProgressBar_bar_filled():
	progressBar.visible = false
	orders += 1
	emit_signal("value_orders_changed",orders)
	animatedSprite.play("cash")
	pass # Replace with function body.


func _on_AnimatedSprite_animation_finished():
	if state == states.TAKING_ORDER:
		animatedSprite.stop()
		state = states.IDLE
	
	
	