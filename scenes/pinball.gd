extends Node2D

@export var run_stats: RunStats

const BALL_SCENE: PackedScene = preload("res://scenes/ball.tscn")

func _ready():
	run_stats.score += 10

func add_ball():
	var new_ball = BALL_SCENE.instantiate()
	new_ball.global_position = Vector2(1258, 212)
	call_deferred("add_child", new_ball)
 
func _on_ball_body_entered(body):
	run_stats.score += 10

func _on_exit_body_entered(body):
	body.queue_free()
	add_ball()
