extends RigidBody2D

var down = false

func drop():
	visible = false
	$CollisionShape2D.call_deferred("set_disabled", true)
	down = true

func raise():
	visible = true
	$CollisionShape2D.call_deferred("set_disabled", false)
	down = false
