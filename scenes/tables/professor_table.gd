extends Table

func _on_exit_body_entered(body):
	body.queue_free()
	add_ball(BALL_SPAWN_POSITION)

func _on_left_kicker_body_entered(body):
	add_score(KICKER_SCORE)

func _on_right_kicker_body_entered(body):
	add_score(KICKER_SCORE)
