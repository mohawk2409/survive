extends Resource
class_name Craft

@export var name: String
@export var icon: Texture2D

@export var items_needed : Dictionary[InvItem, int]
@export var product : InvItem
@export var product_amount : int = 1
@export var crafting_time: float = 5.0
