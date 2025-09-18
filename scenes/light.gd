extends Sprite2D

@export var on_light = Color(1.0, 1.0, 1.0, 1.0)
@export var off_light = Color(1.0, 1.0, 1.0, 0.3)

@onready var timer: Timer = $Timer

var flashes: int = 0
var actual_time: int = 0

func switch_on():
	modulate = on_light
	timer.stop()

func switch_off():
	modulate = off_light
	timer.stop()

func flash_on():
	modulate = on_light
	flashes = 6
	timer.set_one_shot(false)
	timer.start(0.2)

func flash_off():
	if get_modulate() == off_light:
		modulate = on_light
		flashes = 5
	else:
		modulate = off_light
		flashes = 6
	timer.set_one_shot(false)
	timer.start(0.2)

func flash(flash_time = 0.3, first_time = 0.0):
	modulate = on_light
	flashes = -1
	timer.set_one_shot(false)
	if first_time:
		actual_time = flash_time
		timer.start(first_time)
	else:
		timer.start(flash_time)

func flash_once():
	modulate = on_light
	flashes = -1
	timer.set_one_shot(true)
	timer.start(0.15)

func _on_timer_timeout():
	if get_modulate() != off_light:
		modulate = off_light
	else:
		modulate = on_light
	if actual_time:
		timer.start(actual_time)
		actual_time = 0
	if flashes > 0:
		flashes -= 1
		if flashes == 0:
			timer.stop()
