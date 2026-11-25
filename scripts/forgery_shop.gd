extends Area2D
@onready var crafting_system: Control = $CraftingSystem

var entered_zone = false
var opened = false
"""
func _ready():
	crafting_system.close()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fly") and entered_zone and !opened:
		print("I'm opening the crafting UI")
		crafting_system.open()
		opened = true
	elif Input.is_action_just_pressed("fly") and entered_zone and opened:
		crafting_system.close()
		opened = false
"""
func _on_body_entered(body: Node2D) -> void:
	entered_zone = true
	print("je suis entré dans l'aire du shop")


func _on_body_exited(body: Node2D) -> void:
	entered_zone = false
