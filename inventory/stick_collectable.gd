extends StaticBody2D

@export var item: InvItem
var player = null


func _on_interactable_area_body_entered(body: Node2D) -> void:
	print("i'm taking the stick")
	if body.has_method("collect"):
		player = body
		playercollect()
		queue_free()

func playercollect():
	player.collect(item)
