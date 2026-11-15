extends Area2D	
@onready var collision: CollisionShape2D = $CollisionShape2D
var debug_color := Color(1, 0, 0, 0.4)
var show_hitbox := false

func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		show_hitbox = not show_hitbox
		queue_redraw()

func _draw():
	if not show_hitbox:
		return
	draw_set_transform_matrix(collision.transform)
	collision.shape.draw(get_canvas_item(), debug_color)
	
func _process(_delta):
	var held = Input.is_action_pressed("attack")
	if held != show_hitbox:
		show_hitbox = held
		queue_redraw()
