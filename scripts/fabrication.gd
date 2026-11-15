extends Resource

class_name Fab

signal update_fab
var is_open = false

@export var slots: Array[FabSlot]

func insert(item : FabItem, is_not_stackable: bool = false):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty() and !is_not_stackable:
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update_fab.emit()
