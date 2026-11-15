extends Control

@onready var collision_shape_2d: CollisionShape2D = $"../CollisionShape2D"

@onready var label: Label = $PanelContainer/MarginContainer/Label
@onready var panel_container: PanelContainer = $PanelContainer

func _ready():
	panel_container.visible = false

func setVisible(value) -> void:
	panel_container.visible = value
