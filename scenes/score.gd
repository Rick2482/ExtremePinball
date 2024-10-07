extends Panel

@export var run_stats: RunStats

@onready var score_label: Label = $ScoreValue

func _ready():
	Events.score_changed.connect(_on_score_changed)
	
	_on_score_changed()

func _on_score_changed():
	score_label.text = "%s" % [run_stats.score]
