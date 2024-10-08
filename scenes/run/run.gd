extends Node

const PROFESSOR_TABLE: PackedScene = preload("res://scenes/tables/professor_table.tscn")
const ANOTHER_TABLE: PackedScene = preload("res://scenes/tables/another_table.tscn")

@onready var current_table: Node = $CurrentTable

var stats: RunStats

func _ready():
	stats = RunStats.new()
	$BaseUI/Score.run_stats = stats
	Events.show_notification.emit("HELLO")

func _change_table(scene: PackedScene) -> Node:
	if current_table.get_child_count() > 0:
		current_table.get_child(0).queue_free()
	
	get_tree().paused = false
	var new_table = scene.instantiate()
	current_table.add_child(new_table)
	
	return new_table

func _on_professor_table_pressed():
	var new_table := _change_table(PROFESSOR_TABLE)
	new_table.run_stats = stats
	new_table.add_ball(new_table.BALL_SPAWN_POSITION)

func _on_another_table_pressed():
	var new_table := _change_table(ANOTHER_TABLE)
	new_table.run_stats = stats
	new_table.add_ball(new_table.BALL_SPAWN_POSITION)
