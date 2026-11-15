extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"


func _on_body_entered(_body: Node2D) -> void:
	animated_sprite_2d.play("death")
	print("you killed an enemy")
	queue_free()
