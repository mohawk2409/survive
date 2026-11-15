extends Control


@onready var tab: Fab = preload("res://test_fabrication.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var is_open = false

func _ready():
	tab.update_fab.connect(update_slots)
	update_slots()
	close()
func update_slots():
	for i in range(min(tab.slots.size(), slots.size())):
		slots[i].update_fab(tab.slots[i])

func _process(_delta):
	if Input.is_action_just_pressed("fly"):
		if is_open:
			close()
		else:
			open()
func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
