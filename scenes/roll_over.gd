extends Area2D

@export var roll_over_sound: AudioStream

var activated: bool = false

func _on_body_entered(body: Node2D) -> void:
	if activated:
		SFXPlayer.play(roll_over_sound)
	activated = false
