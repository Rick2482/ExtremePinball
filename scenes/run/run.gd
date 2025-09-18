extends Node

const PROFESSOR_TABLE: PackedScene = preload("res://scenes/tables/professor_table.tscn")
const ANOTHER_TABLE: PackedScene = preload("res://scenes/tables/another_table.tscn")

@onready var current_view: Node = $CurrentView
@onready var game_over_panel: NinePatchRect = $GameOverPanel

var current_table: Table

var stats: GameStats
var game_running: bool = false

func _ready():
	Events.score_changed.connect(_on_score_changed)
	Events.ball_lost.connect(_on_ball_lost)
	Events.game_over.connect(_on_game_over)
	
	current_table = _change_table(PROFESSOR_TABLE) as Table
	new_game()

func _process(delta):
	if Input.is_action_pressed("start") and !game_running:
		new_game()

func new_game():
	current_table.initialize()
	
	stats = GameStats.new()
	if not current_table:
		return
	current_table.game_stats = stats
	current_table.add_ball(current_table.BALL_SPAWN_POSITION)
	game_running = true
	Events.game_started.emit()

func reset_all():
	game_running = false
	Events.game_ended.emit()

func _change_table(scene: PackedScene) -> Node:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	if game_running:
		reset_all()
	
	get_tree().paused = false
	var new_table = scene.instantiate()
	current_view.add_child(new_table)
	
	return new_table

func _on_professor_table_pressed():
	current_table = _change_table(PROFESSOR_TABLE) as Table

func _on_another_table_pressed():
	current_table = _change_table(ANOTHER_TABLE) as Table

func _on_score_changed():
	$BaseUI/ScoreLabel.text = "%s" % [stats.score]

func _on_ball_lost():
	current_table.add_ball(current_table.BALL_SPAWN_POSITION)
	stats.multiplier = 1
	current_table.light_multiplierx2.switch_off()
	current_table.light_multiplierx4.switch_off()
	current_table.light_multiplierx8.switch_off()

func _on_game_over():
	game_running = false
	game_over_panel.visible = true
	$LeftAstenButton.visible = false
	$RightAstenButton.visible = false
	Events.game_ended.emit()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_retry_button_pressed() -> void:
	stats.score = 0
	stats.balls = 3
	$LeftAstenButton.visible = true
	$RightAstenButton.visible = true
	current_table.add_ball(current_table.BALL_SPAWN_POSITION)
	game_over_panel.visible = false
