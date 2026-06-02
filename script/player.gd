extends CharacterBody2D

@export var speed = 300

@export var left_action = ""
@export var right_action= ""
@export var up_action= ""
@export var down_action= ""

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed(left_action):
		direction.x -= 1
	if Input.is_action_pressed(right_action):
		direction.x += 1
	if Input.is_action_pressed(up_action):
		direction.y -= 1
	if Input.is_action_pressed(down_action):
		direction.y += 1
	velocity = direction.normalized() * speed
	move_and_slide()
