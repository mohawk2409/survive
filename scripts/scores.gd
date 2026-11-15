extends Control
@onready var label: Label = $Label

func handle_gain_coins(value):
	label.set_text(str(value))
