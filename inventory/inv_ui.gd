extends Control

@onready var inv: Inv = preload("res://inventory/player_inv.tres")
@onready var bottom_slots: Array = $bottom_inv_ui/NinePatchRect/GridContainer.get_children()
@onready var inv_slots: Array = $inv_ui/NinePatchRect/GridContainer.get_children()
@onready var slots: Array = bottom_slots + inv_slots   # index 0–7 = bar, 8–19 = bag
@onready var held_item: TextureRect = $HeldItem

var player = null

var item_visual_tmp: Sprite2D = null
var amount_text_tmp: Label = null
var dragged_index: int = -1
var is_open = false
func _ready():
	player = get_tree().get_first_node_in_group("player")
	inv.update.connect(update_slots)
	for inv_slot in slots:
		inv_slot.gui_input.connect(slot_gui_input.bind(inv_slot))	
		update_slots()
	close()
	#for inv_slot in slots:
		#inv_slot.connect(self,"slot_gui_input", [inv_slot])

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _process(_delta):
	if held_item.visible:
		held_item.global_position = get_global_mouse_position() - held_item.size / 2
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()
func open():
	$inv_ui.visible = true
	is_open = true
	
func close():
	$inv_ui.visible = false
	is_open = false

func get_slot_index_under_mouse() -> int:
	var mouse_pos = get_global_mouse_position()
	for i in slots.size():
		if slots[i].get_global_rect().has_point(mouse_pos):
			return i
	return -1


func slot_gui_input(event: InputEvent, slot: InvUISlot):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var index = slots.find(slot)
			if inv.slots[index].item == null:
				return                      # nothing to drag from an empty slot
			dragged_index = index
			held_item.texture = inv.slots[index].item.texture
			held_item.visible = true
			slot.item_visual.visible = false   # hide the icon in the source slot
		elif dragged_index != -1:
			slots[dragged_index].item_visual.visible = true
			held_item.visible = false
			var target_index = get_slot_index_under_mouse()
			if target_index != -1 and target_index != dragged_index:
				var tmp = inv.slots[dragged_index]
				inv.slots[dragged_index] = inv.slots[target_index]
				inv.slots[target_index] = tmp
				update_slots()
			dragged_index = -1

func remove_item(item : InvItem, amount : int = 1):
	for slot in slots:
		if slot.item == item:
			slot.amount -= amount
			return


func use_items_needed(items_needed : Inv):
	for key in items_needed:
		slots[key] -= items_needed[key]
		remove_item(key, items_needed[key])


func check_items_needed(items_needed : Inv):
	for key in items_needed:
		if slots[key] < items_needed[key]:
			return false
	return true
