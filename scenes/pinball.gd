extends Node2D

@export var run_stats: RunStats

# Called when the node enters the scene tree for the first time.
func _ready():
	run_stats.score += 10

func new_ball():
	pass
 
func _on_ball_body_entered(body):
	run_stats.score += 10

func _on_exit_body_entered(body):
	body.queue_free()
