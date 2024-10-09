extends Table

@onready var line: Line2D = $DebugLine

var first_mission = preload("res://missions/first_mission.tres")
var second_mission = preload("res://missions/second_mission.tres")

var current_mission = first_mission

func _ready():
	Events.mission_completed.connect(_on_mission_completed)

func kick(ball, kicker, force):
	impact(ball)
	add_score(KICKER_SCORE)
	ball.apply_central_impulse(Vector2.RIGHT.rotated(kicker.get_global_rotation()) * force)

func bump(ball, bumper, force):
	impact(ball)
	add_score(BUMPER_SCORE)
	var bump_direction: Vector2 = ball.global_position - bumper.global_position
	ball.apply_central_impulse(bump_direction.normalized() * force)

func _on_mission_completed():
	game_stats.score += current_mission.reward
	current_mission = null

func _on_exit_body_entered(body):
	body.queue_free()
	Events.game_over.emit()

func _on_left_kicker_body_entered(body):
	kick(body, $LeftKicker, FORCE_KICKER)

func _on_right_kicker_body_entered(body):
	kick(body, $RightKicker, FORCE_KICKER)

func _on_bumper_body_entered(body):
	bump(body, $Bumper, FORCE_BUMPER)

func _on_bumper_2_body_entered(body):
	bump(body, $Bumper2, FORCE_BUMPER)

func _on_bumper_3_body_entered(body):
	bump(body, $Bumper3, FORCE_BUMPER)

func _on_rigid_body_2d_body_entered(body):
	if current_mission is FirstMission:
		current_mission.complete_objective(current_mission.OBJECTIVE_1)

func _on_roll_over_body_entered(body):
	if current_mission is FirstMission:
		current_mission.complete_objective(current_mission.OBJECTIVE_2)
