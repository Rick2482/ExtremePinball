extends Panel

@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	Events.show_notification.connect(_on_show_notification)

func _on_show_notification(text: String):
	animation_player.play("text")
	label.text = text
