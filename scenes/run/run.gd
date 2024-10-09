extends Node

const PROFESSOR_TABLE: PackedScene = preload("res://scenes/tables/professor_table.tscn")
const ANOTHER_TABLE: PackedScene = preload("res://scenes/tables/another_table.tscn")

@onready var current_view: Node = $CurrentView
@onready var notifier: Panel = $BaseUI/Notifier

var current_table: Table

var stats: GameStats
var game_running: bool = false

func _ready():
	Events.game_over.connect(_on_game_over)

func _process(delta):
	if Input.is_action_pressed("spawn_ball") and !game_running:
		new_game()

func new_game():
	stats = GameStats.new()
	$BaseUI/Score.game_stats = stats
	if not current_table:
		notifier.notify("Devi selezionare un tavolo per poter giocare!")
		return
	current_table.game_stats = stats
	current_table.add_ball(current_table.BALL_SPAWN_POSITION)
	game_running = true

func reset_all():
	game_running = false
	$BaseUI/Score.score_label.text = "0"

func _change_table(scene: PackedScene) -> Node:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	if game_running:
		reset_all()
	
	get_tree().paused = false
	var new_table = scene.instantiate()
	current_view.add_child(new_table)
	notifier.notify("Premi Invio per Iniziare")
	
	return new_table

func _on_professor_table_pressed():
	current_table = _change_table(PROFESSOR_TABLE) as Table

func _on_another_table_pressed():
	current_table = _change_table(ANOTHER_TABLE) as Table

func _on_game_over():
	game_running = false
