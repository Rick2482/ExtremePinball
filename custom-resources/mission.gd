class_name Mission
extends Resource

@export var name: String
@export var description: String
@export var reward: int
#This should be 2^(number of objectives - 1)
@export var all_objectives: int = 0

var objectives: int = 0

func is_objective_completed(objective_flag: int):
	return objectives & objective_flag != 0

func complete_objective(objective_flag: int):
	objectives |= objective_flag
	if is_mission_completed():
		Events.mission_completed.emit()

func clear_objective(objective_flag: int):
	objectives &= ~objective_flag

func is_mission_completed():
	return (objectives & all_objectives) == all_objectives
