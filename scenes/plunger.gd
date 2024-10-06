extends Node2D

@export var max_extension_time: float = 0.3
@export var temp: float = 1.0
@export var y_amount: float = 50

var y_position
var intermediate_time: float = 0.0

func _ready():
	y_position = global_position.y

func _physics_process(delta):
	if Input.is_action_pressed("Shoot"):
		if intermediate_time <= max_extension_time:      
			intermediate_time += delta
			if intermediate_time > max_extension_time:
				intermediate_time = max_extension_time
			var y_increment = (intermediate_time / max_extension_time) * y_amount
			global_position.y = y_position + y_increment
	else:
		if intermediate_time > 0.0:
			intermediate_time -= delta
			if intermediate_time < 0.0:
				intermediate_time = 0.0
			var y_increment = (intermediate_time / temp) * y_amount
			global_position.y = y_position - y_increment
