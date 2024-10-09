extends RigidBody2D

const CLAMP_VELOCITY = 3500.0

func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
	if velocity.length() > CLAMP_VELOCITY:
		state.set_linear_velocity(Vector2(clampf(velocity.x, 0.0, CLAMP_VELOCITY), clampf(velocity.y, 0.0, CLAMP_VELOCITY)))
