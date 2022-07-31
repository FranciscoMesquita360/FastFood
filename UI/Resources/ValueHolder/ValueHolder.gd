extends Label
var sceneText = load("res://UI/Text/Text.tscn")
var value_current:String = "0"
var value_previous:String
var difference_value
signal value_changed
var value_text:Label
func _ready():
	value_previous = value_current
	value_text = $Value
	pass
	
		
func set_value(var _value):
	if _value != int(value_current):
		value_previous  = value_current
		value_current = str(_value)
		text = value_current
		emit_signal("value_changed")

func _on_ValueHolder_value_changed():
	difference_value = int(value_current)-int(value_previous)
	var instanceScene = sceneText.instance()
	add_child(instanceScene)
	if difference_value >= 0:
		instanceScene.set_color("yellow")
		instanceScene.set_text("+"+str(difference_value))
	else:
		instanceScene.set_color("red")
		instanceScene.set_text(str(difference_value))
	
	instanceScene.position = Vector2(0,0)
	pass # Replace with function body.

