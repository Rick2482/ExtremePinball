extends StaticBody2D

var raised: bool = false

func raise():
	$CollisionShape2D.set_deferred("disabled", false)
	set_visible(true)
	raised = true

func lower():
	$CollisionShape2D.set_deferred("disabled", true)
	set_visible(false)
	raised = false

func is_activated():
	return raised
