extends RigidBody2D

@export var kicker_sound: AudioStream

func _on_body_entered(body: Node) -> void:
	SFXPlayer.play(kicker_sound)
