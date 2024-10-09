class_name GameStats
extends Resource

@export var score := 0 : set = set_score

func _ready():
	Events.score_changed.emit()

func set_score(new_score: int):
	score = new_score
	Events.score_changed.emit()
