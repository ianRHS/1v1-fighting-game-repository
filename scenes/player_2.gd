extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var speed = 300.0
@export var gravity = 980.0

@export var left_action = ""
@export var right_action = ""
@export var up_action = ""
@export var down_action = ""

# Track if the player is currently attacking
var is_attacking = false

func _ready():
	# Connect the signal so we know exactly when the attack animation ends
	animated_sprite.animation_finished.connect(_on_animation_finished)

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed(up_action) and is_on_floor():
		velocity.y = -500

	# Get movement direction
	var direction = 0.0
	if Input.is_action_pressed(left_action):
		direction -= 1
	if Input.is_action_pressed(right_action):
		direction += 1

	# Horizontal movement
	velocity.x = direction * speed

	# Handle Attack Input
	if Input.is_action_just_pressed("p2_attack") and not is_attacking:
		is_attacking = true
		animated_sprite.play("Attack")

	# Handle Animations and Flipping (only if NOT attacking)
	if not is_attacking:
		if direction != 0:
			animated_sprite.play("Run") # Optional: If you have a running animation
		else:
			animated_sprite.play("Idle")

	# Flip sprite based on movement (only when actually moving)
	if direction < 0:
		animated_sprite.flip_h = true
	elif direction > 0:
		animated_sprite.flip_h = false
	move_and_slide()

# This function runs automatically when ANY animation finishes
func _on_animation_finished():
	if animated_sprite.animation == "Attack":
		is_attacking = false
