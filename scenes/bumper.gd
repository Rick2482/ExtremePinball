extends RigidBody2D

@export var bumper_sound: AudioStream

func _on_body_entered(body: Node) -> void:
	SFXPlayer.play(bumper_sound)
