extends Camera2D

@onready var camera_2d: Camera2D = $"."

var e_pressed: bool = false
var vect: Vector2 = Vector2(1.5,1.5)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("i") and !e_pressed:
		e_pressed = true
		#camera_2d.set_zoom(Vector2(5,5))
		camera_2d.move_local_x(80)
	elif Input.is_action_just_pressed("i") and e_pressed:
		e_pressed = false
		#camera_2d.set_zoom(Vector2(4,4))
		camera_2d.move_local_x(-80)
