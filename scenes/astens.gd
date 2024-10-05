extends Node2D

@export var rotation_speed := 10.0
@export var max_rotation := 45.0
@export var min_rotation := -45.0

var is_rotating_left := false
var is_rotating_right := false

func _physics_process(delta):
	if Input.is_action_pressed("left-astens"):
		if rotation_degrees > min_rotation:
			self.angular_velocity = -rotation_speed
	elif Input.is_action_pressed("right-astens"):
		if rotation_degrees < max_rotation:
			self.angular_velocity = rotation_speed
	else:
		self.angular_velocity = 0.0
