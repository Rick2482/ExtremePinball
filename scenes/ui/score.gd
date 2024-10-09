extends Panel

@export var game_stats: GameStats

@onready var score_label: Label = $ScoreValue

func _ready():
	Events.score_changed.connect(_on_score_changed)

func _on_score_changed():
	score_label.text = "%s" % [game_stats.score]
