extends Panel


signal completed(item, node)

var craft: Craft:
	set(value):
		craft = value
		
		if value == null:
			return
		$TextureRect.texture = value.icon
		craft_time = value.crafting_time

var craft_time: float:
	set(value):
		craft_time = value
		$ProgressBar.max_value = value


var time : float = 0:
	set(value):
		time = value
		$ProgressBar.value = value

func _physics_process(delta):
	if time >= 0 and get_index() == 0:
		time += delta
	if time > craft_time:
		completed.emit(craft, self)
 
 
func _on_cancel_pressed():
	#for key in craft.items_needed:
		#inv_ui.add_item(key, craft.items_needed[key])
	queue_free()
