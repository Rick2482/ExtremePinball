extends RigidBody2D

@export var drop_target_sound: AudioStream

var down = false

func drop():
	SFXPlayer.play(drop_target_sound)
	visible = false
	$CollisionShape2D.call_deferred("set_disabled", true)
	down = true

func raise():
	visible = true
	$CollisionShape2D.call_deferred("set_disabled", false)
	down = false
