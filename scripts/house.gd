extends Area2D
@onready var text_box: Control = $TextBox


func _ready():
	text_box.label.text = "Tiens... Une maison abandonnée, 
	je me demande à qui elle appartenait..."

func _on_mouse_entered() -> void:
	text_box.setVisible(true)


func _on_mouse_exited() -> void:
	text_box.setVisible(false)
