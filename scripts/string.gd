extends Node2D


@export var item: InvItem
var player = null
var index: int = 100
func _ready():
	player = get_tree().get_first_node_in_group("player")


func _on_body_entered(body: Node2D) -> void:
	print("i am taking the string")
	player = body
	player.collect(item, false)
	index = player.inv.index(item)
	queue_free()
"""	print("The axe index is ", index)
	if item.name == "axe":
		if index == 0:
			player.set_damage(2)
			print("The new value of damage is ", player.damage)
		"""
	
