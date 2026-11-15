extends CharacterBody2D

@onready var area_2d: Area2D = $Area2D

const AttackingZone = preload("uid://gtxy6x64q3b")

const SPEED = 300.0
var JUMP_VELOCITY = -400.0
var damage = 1
@export var health: int = 3
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@export var inv: Inv
var zero_gravity = false
var is_attacking = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
func _enter_tree():
	add_to_group("player")
		
func _ready():
	_enter_tree()
	animated_sprite_2d.animation_finished.connect(_on_animation_finished)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity()*1.5 * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")		
	if direction < 0:
		animated_sprite_2d.flip_h = true
		collision_shape_2d.position = Vector2(-12,-16)
	elif direction > 0:
		animated_sprite_2d.flip_h = false
		collision_shape_2d.position = Vector2(-12* (-direction),-16)

	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		animated_sprite_2d.play("attack_1")
		collision_shape_2d.visible = true
		for area in area_2d.get_overlapping_areas():
			if area.is_in_group("enemy_hurtbox"):
				area.get_parent().take_damage(damage)
				print("The enenmy takes damage")
	if not is_attacking:
		if is_on_floor():
			if direction == 0:
				animated_sprite_2d.play("Idle")
			elif direction == 0:
				animated_sprite_2d.play("Idle")
			else:
				animated_sprite_2d.play("Run")
		else:
			animated_sprite_2d.play("Jump")
		
	
	if direction:
		velocity.x = direction * SPEED*0.75
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_animation_finished():
	if animated_sprite_2d.animation == "attack_1":
		is_attacking = false

func collect(item, is_not_stackable = false):
	inv.insert(item,is_not_stackable)

func get_health():
	return health


func set_damage(value: int):
	damage += value
	#print("The new value of damage is ", damage)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("debug")
	if body.is_in_group("enemies"):
		print("Enemy hit: ", body.name)
