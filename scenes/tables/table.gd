class_name Table
extends Node2D

signal initialization_finished

@export var BALL_SPAWN_POSITION: Vector2

@export_group("Score points")
@export var BUMPER_SCORE: int
@export var DROP_SCORE: int
@export var DROP_ALL_SCORE: int
@export var KICKER_SCORE: int
@export var LANE_SCORE: int
@export var LANE_HUNT_SCORE: int
@export var TARGET_HUNT_SCORE: int
@export var ALL_BUMPERS_SCORE: int
@export var LOOP_SCORE: int
@export var JACKPOT_SCORE: int
@export var WIZARD_LANE_SCORE: int
@export var BONUS_SCORE: int
@export var SKILL_SHOT_SCORE: int

const RELEASE_FORCE = 750
const NUDGE_V_FORCE = 300
const NUDGE_H_FORCE = 300
const NUDGE_VIEW_OFFSET = 10
const FORCE_BUMPER = 700.0
const FORCE_KICKER = 1200.0

var game_stats: GameStats

const BALL_SCENE: PackedScene = preload("res://scenes/ball.tscn")
const IMPACT_SCENE: PackedScene = preload("res://scenes/impact.tscn")

func initialize():
	pass

func add_ball(pos: Vector2):
	var new_ball = BALL_SCENE.instantiate()
	new_ball.global_position = pos
	call_deferred("add_child", new_ball)

func add_score(points):
	game_stats.score += game_stats.multiplier * points

func impact(ball):
	var new_impact = IMPACT_SCENE.instantiate()
	new_impact.global_position = ball.global_position
	call_deferred("add_child", new_impact)
