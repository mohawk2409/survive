extends Node2D
	
const SPEED = 60

var direction = 1
@onready var game: Node2D = $"../.."
@onready var node_2d: Node2D = $"."
const KILLZONE_OFFSET = Vector2(7,1)
var health = 1

var player: CharacterBody2D

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d_killing_zone: CollisionShape2D = $killingzone/CollisionShape2D
@onready var ray_cast_down_left: RayCast2D = $RayCastDownLeft
@onready var ray_cast_down_right: RayCast2D = $RayCastDownRight

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	player = get_tree().get_first_node_in_group("player")
	set_direction(direction)
	
func _physics_process(delta: float) -> void:
	if direction == 1:
		# Il va à droite : mur à droite ou vide à droite -> demi-tour
		if ray_cast_right.is_colliding() or not ray_cast_down_right.is_colliding():
			set_direction(-1)
	else:
		# Il va à gauche : mur à gauche ou vide à gauche -> demi-tour
		if ray_cast_left.is_colliding() or not ray_cast_down_left.is_colliding():
			set_direction(1)
	position.x += SPEED * delta * direction

func set_direction(new_direction: int) -> void:
	direction = new_direction
	animated_sprite_2d.flip_h = (direction == 1)
	# Valeur absolue calculée à partir de la direction, jamais "= -position"
	collision_shape_2d_killing_zone.position = Vector2(KILLZONE_OFFSET.x * direction, KILLZONE_OFFSET.y)

func _on_killingzone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("here")
		queue_free()
		game.handle_coins(3)

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		print("The enemy is dead")
		queue_free()
		game.handle_coins(3)

func _on_killzone_body_entered(_body: Node2D) -> void:
	print("I'm dead")
	print(player.health)
	player.health -= 1
	print(player.health)
	if player.health == 0:
		get_tree().call_deferred("reload_current_scene")

	
	#get_tree().call_deferred("reload_current_scene")
