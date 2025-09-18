extends Node2D

@export var keycode = "shoot"
@export var eject_sound: AudioStream
@export var full_extension: float = 80
@export var pull_time: float = 1.0
@export var release_time: float = 0.05

@onready var body: RigidBody2D = $RigidBody2D

var release_speed = 0.0

func _physics_process(delta):
	var y = body.get_position().y
	if Input.is_action_pressed(keycode):
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
				SFXPlayer.play(eject_sound)
			body.set_position(Vector2(0, y))
