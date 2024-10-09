extends Panel

@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var notification_timer: Timer = $Timer

func _ready():
	Events.show_notification.connect(_on_show_notification)
	notification_timer.timeout.connect(_on_notification_timer_finished)

func notify(text: String):
	animation_player.play("text")
	label.text = text
	notification_timer.start()

func _on_show_notification(text: String):
	notify(text)

func _on_notification_timer_finished():
	animation_player.play("RESET")
