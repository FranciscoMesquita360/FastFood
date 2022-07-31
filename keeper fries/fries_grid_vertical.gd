extends Sprite
var fries:Array
var index
func _ready():
	fries = get_children()
	index = fries.size()-1
	pass


func _on_ProgressBar_bar_filled():
	fries[index].visible = false
	index = index - 1
	pass # Replace with function body.
