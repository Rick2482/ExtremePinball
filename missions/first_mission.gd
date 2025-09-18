class_name FirstMission
extends Mission

const OBJECTIVE_1 = 1 << 0  # 1
const OBJECTIVE_2 = 1 << 1  # 2
const OBJECTIVE_3 = 1 << 2  # 4

func _init():
	# Dynamically calculate all_objectives
	all_objectives = OBJECTIVE_1 | OBJECTIVE_2 | OBJECTIVE_3
