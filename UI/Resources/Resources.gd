extends Position2D
var rawMeat:Label
var cookedMeat:Label
var tostedMeat:Label
var ordersCount:Label
var friesCount:Label
func _ready():
	rawMeat = $MarginContainer2/MarginContainer/VBoxContainer/HBoxContainer/ValueHolder
	cookedMeat = $MarginContainer2/MarginContainer/VBoxContainer/HBoxContainer2/ValueHolder
	tostedMeat = $MarginContainer2/MarginContainer/VBoxContainer/HBoxContainer3/ValueHolder
	ordersCount = $MarginContainer2/MarginContainer/VBoxContainer/HBoxContainer4/ValueHolder
	friesCount = $MarginContainer2/MarginContainer/VBoxContainer/HBoxContainer5/ValueHolder
	pass


func _on_Grill_meats_variables_changed(cooked_meats,tosted_meats):
	cookedMeat.set_value(cooked_meats)
	tostedMeat.set_value(tosted_meats)
	pass # Replace with function body.


func _on_Fridge_meat_value_changed(meats_avaiable):
	rawMeat.set_value(meats_avaiable)

func _on_cash_register_value_orders_changed(orders):
	ordersCount.set_value(orders)
	pass # Replace with function body.


func _on_KeeperFries_fries_value_changed(fries):
	friesCount.set_value(fries)
	pass # Replace with function body.
