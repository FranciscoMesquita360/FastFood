extends Position2D
var sceneText = load("res://UI/Text/Text.tscn")
var parent
func _ready():
	parent = get_parent()
	
	pass


func _on_Fridge_fridge_empty():
	var instanceScene = sceneText.instance()
	add_child(instanceScene)
	instanceScene.position = Vector2(0,0)
	instanceScene.set_text("NO MEATS")
	pass # Replace with function body.


func _on_Fridge_meat_value_changed(value):
	if value == 0:
		var instanceScene = sceneText.instance()
		add_child(instanceScene)
		instanceScene.position = Vector2(0,0)
		instanceScene.set_text("NO MEATS")
