extends Resource

class_name Inv

signal update 

var holding_item = null
@export var slots: Array[InvSlot]

	

func insert(item : InvItem, is_not_stackable: bool = false):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty() and !is_not_stackable:
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()
