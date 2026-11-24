extends Panel
 
signal selected(craft, node)
 
var craft : Craft:
	set(value):
		craft = value
		%Name.text = value.name
		%Product.texture = value.icon
		for i in range(value.items_needed.size()):
			var key = value.items_needed.keys()[i]
			%items.get_child(i).texture = key.texture
			%items.get_child(i).find_child("amount").text = str(value.items_needed[key])
 
 
func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			selected.emit(craft, self)
