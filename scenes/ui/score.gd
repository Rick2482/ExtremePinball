extends Panel

@export var game_stats: GameStats

@onready var score_label: Label = $ScoreValue

func _ready():
	Events.game_started.connect(_on_game_started)
	Events.score_changed.connect(_on_score_changed)
	Events.game_ended.connect(_on_game_ended)

func _on_game_started():
	visible = true

func _on_score_changed():
	score_label.text = "%s" % [game_stats.score]

func _on_game_ended():
	visible = false
