extends Table

const first_mission = preload("res://missions/first_mission.tres")
const second_mission = preload("res://missions/second_mission.tres")

@onready var left_targets: Node2D = $LeftTargets
@onready var right_targets: Node2D = $RightTargets

@onready var lane_lights: Node2D = $LaneLights
@onready var power_lights: Node2D = $PowerLights
@onready var multiplier_lights: Node2D = $MultipliersLights
@onready var special_lights: Node2D = $SpecialLights

@onready var light_multiplierx2: Sprite2D = $MultipliersLights/LightMultiplierx2
@onready var light_multiplierx4: Sprite2D = $MultipliersLights/LightMultiplierx4
@onready var light_multiplierx8: Sprite2D = $MultipliersLights/LightMultiplierx8

var missions = [first_mission, second_mission]

var current_mission

func _ready():
	current_mission = missions.pop_front()
	Events.mission_completed.connect(_on_mission_completed)
	$BallCapture.activated = true

func initialize():
	flash_all_lights()
	
	get_tree().create_timer(2).timeout.connect(func():
		stop_all_lights()
		
		$RollOver.activated = true
		$RollOver2.activated = true
		$RollOver3.activated = true
		
		$LaneLights/Light.switch_on()
		$LaneLights/Light2.switch_on()
		$LaneLights/Light6.switch_on()
		$LaneLights/Light7.switch_on()
	)
	
	initialization_finished.emit()

func flash_all_lights():
	for light in lane_lights.get_children():
		light.flash()
	
	for light in power_lights.get_children():
		light.flash()
	
	for light in multiplier_lights.get_children():
		light.flash()
	
	for light in special_lights.get_children():
		light.flash()

func flash_all_lights_once():
	for light in lane_lights.get_children():
		light.flash_once()
	
	for light in power_lights.get_children():
		light.flash_once()
	
	for light in multiplier_lights.get_children():
		light.flash_once()
	
	for light in special_lights.get_children():
		light.flash_once()

func stop_all_lights():
	for light in lane_lights.get_children():
		light.switch_off()
	
	for light in power_lights.get_children():
		light.switch_off()
	
	for light in multiplier_lights.get_children():
		light.switch_off()
	
	for light in special_lights.get_children():
		light.switch_off()

func raise_all_gates():
	for gate in $Gates.get_children():
		gate.raise()

func lower_all_gates():
	for gate in $Gates.get_children():
		gate.lower()

func kick(ball, kicker, force):
	impact(ball)
	add_score(KICKER_SCORE)
	ball.apply_central_impulse(Vector2.from_angle(kicker.get_global_rotation()) * force)

func bump(ball, bumper, force):
	impact(ball)
	add_score(BUMPER_SCORE)
	var bump_direction: Vector2 = ball.global_position - bumper.global_position
	ball.apply_central_impulse(bump_direction.normalized() * force)

func _on_mission_completed():
	add_score(current_mission.reward)
	
	flash_all_lights()
	current_mission = missions.pop_front()
	
	get_tree().create_timer(2).timeout.connect(func():
		stop_all_lights()
		$LaneLights/Light8.switch_on()
		$RollOver5.activated = true
		)

func _on_exit_body_entered(body):
	body.queue_free()
	game_stats.balls -= 1
	lower_all_gates()
	if game_stats.balls == 0:
		Events.game_over.emit()
		return
	Events.ball_lost.emit()

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

func check_drop_targets(target_array: Array, is_left: bool = true):
	var all_down: bool = true
	for target in target_array:
		if not target.down:
			all_down = false
	if all_down:
		if current_mission is SecondMission and is_left:
			$PowerLights/Light.switch_off()
			$SpecialLights/Light.switch_on()
			
		for target in target_array:
			target.raise()

func _on_drop_target_body_entered(body):
	impact(body)
	$LeftTargets/DropTarget.drop()
	check_drop_targets(left_targets.get_children())

func _on_drop_target_2_body_entered(body):
	impact(body)
	$LeftTargets/DropTarget2.drop()
	check_drop_targets(left_targets.get_children())

func _on_drop_target_3_body_entered(body):
	impact(body)
	$LeftTargets/DropTarget3.drop()
	check_drop_targets(left_targets.get_children())

func _on_drop_target_4_body_entered(body):
	impact(body)
	$RightTargets/DropTarget4.drop()
	check_drop_targets(right_targets.get_children(), false)

func _on_drop_target_5_body_entered(body):
	impact(body)
	$RightTargets/DropTarget5.drop()
	check_drop_targets(right_targets.get_children(), false)

func _on_drop_target_6_body_entered(body):
	impact(body)
	$RightTargets/DropTarget6.drop()
	check_drop_targets(right_targets.get_children(), false)

func _on_roll_over_body_entered(body):
	if current_mission is FirstMission:
		$LaneLights/Light.switch_off()
		$LaneLights/Light6.switch_off()
		current_mission.complete_objective(current_mission.OBJECTIVE_3)

func _on_roll_over_2_body_entered(body):
	if current_mission is FirstMission:
		$LaneLights/Light2.switch_off()
		if not current_mission.is_objective_completed(current_mission.OBJECTIVE_2):
			$LaneLights/Light7.switch_on()
		current_mission.complete_objective(current_mission.OBJECTIVE_1)

func _on_roll_over_3_body_entered(body: Node2D) -> void:
	if current_mission is FirstMission:
		$LaneLights/Light7.switch_off()
		if not current_mission.is_objective_completed(current_mission.OBJECTIVE_3):
			$LaneLights/Light.switch_on()
			$LaneLights/Light6.switch_on()
		current_mission.complete_objective(current_mission.OBJECTIVE_2)

func _on_roll_over_4_body_entered(body: Node2D) -> void:
	get_tree().create_timer(2).timeout.connect(func():
		raise_all_gates()
	)

func _on_roll_over_5_body_entered(body: Node2D) -> void:
	if current_mission is SecondMission:
		$LaneLights/Light8.switch_off()
		$PowerLights/Light.switch_on()

func _on_ball_capture_body_entered(body: Node2D) -> void:
	$BallCapture.activated = true
	
	if current_mission is SecondMission:
		pass
	
	if game_stats.multiplier == 1:
		light_multiplierx2.switch_on()
		game_stats.multiplier = 2
	elif game_stats.multiplier == 2:
		light_multiplierx4.switch_on()
		game_stats.multiplier = 4
	elif game_stats.multiplier == 4:
		light_multiplierx8.switch_on()
		game_stats.multiplier = 8
