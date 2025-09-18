extends RigidBody2D

const CLAMP_VELOCITY = 3500.0
const MIN_TRAIL_VELOCITY = 2000.0

func _process(delta):
	var speed = get_linear_velocity().length()
	$CPUParticles2D.set_emitting(speed > MIN_TRAIL_VELOCITY)

func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
	if velocity.length() > CLAMP_VELOCITY:
		velocity.clampf(0, CLAMP_VELOCITY)
		state.set_linear_velocity(velocity.clampf(0, CLAMP_VELOCITY))
