extends Control

@onready var craft_slot_node: PackedScene = preload("res://scenes/crafting_slot.tscn")
@onready var queue_slot_node: PackedScene = preload("res://scenes/queue_slot.tscn")
@onready var inv_ui: Control = $"../inv_ui"
@export var crafts: Array[Craft]:
	set(value):
		crafts = value
 
		if craft_container:
			free_slots()
			load_recipes()


@export var craft_container : VBoxContainer
@export var queue : VBoxContainer

var selected_craft: Craft
var selected_rect: Rect2

func _ready():
	free_slots()
	load_recipes()

func _draw():
	draw_rect(selected_rect, Color.WHITE, false, 1)

func load_recipes():
	for craft in crafts:
		var craft_slot = craft_slot_node.instantiate()
		craft_container.add_child(craft_slot)
		craft_slot.craft = craft
		craft_slot.selected.connect(selection)

func free_slots():
	for slot in craft_container.get_children():
		slot.free()

func selection(item : Craft, node : Panel):
	selected_craft = item
	selected_rect = Rect2(node.global_position, node.size)
	queue_redraw()
	print(item.name)


func _on_button_pressed() -> void:
	if not selected_craft:
		return
 
	if not inv_ui.check_items_needed(selected_craft.items_needed):
		print("Not Enough Items")
		return
 
	inv_ui.use_items_needed(selected_craft.items_needed)
 
	queue_item(selected_craft)
	
func queue_item(item : Craft):
	if item == null:
		return
 
	var queue_slot = queue_slot_node.instantiate()
	queue.add_child(queue_slot)
	queue_slot.recipe = item
	queue_slot.completed.connect(finished_crafting)

func finished_crafting(item : Craft, node : Panel):
	if item == null:
		return
 
	inv_ui.add_item(item.product, item.product_amount)
	node.queue_free()
	print(item.name +" added.")
