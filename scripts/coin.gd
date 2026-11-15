extends Area2D

const Game = preload("uid://375dofuor7hs")
@onready var game: Node2D = $"../.."


func _on_body_entered(_body: Node2D) -> void:
	print("+1 coin")
	game.handle_coins(1)
	queue_free()
