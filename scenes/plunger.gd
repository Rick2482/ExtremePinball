extends Node2D

@onready var body: RigidBody2D = $RigidBody2D

@export var full_extension: float = 80
@export var pull_time: float = 1.0
@export var release_time: float = 0.05

var release_speed = 0.0

func _physics_process(delta):
	var y = body.get_position().y
	if Input.is_action_pressed("Shoot"):
		if y < full_extension:
			y += (full_extension / pull_time) * delta
			if y > full_extension:
				y = full_extension
			body.set_position(Vector2(0, y))
	else:
		if y > 0.0:
			if release_speed == 0.0:
				release_speed = y / release_time
			y -= release_speed * delta
			if y <= 0.0:
				y = 0.0
				release_speed = 0.0
			body.set_position(Vector2(0, y))
