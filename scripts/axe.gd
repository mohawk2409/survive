extends Node2D


@export var item: Weapon
var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")


func _on_body_entered(body: Node2D) -> void:
	print("i'm taking the axe and its damage value is : ", item.damage)
	player.set_damage(2)
	print("The new value of damage is ", player.damage)
	player = body
	player.collect(item, true)
	queue_free()
