extends CPUParticles2D

func _ready():
	emitting = true
	finished.connect(_on_impact_finished)

func _on_impact_finished():
	queue_free()
