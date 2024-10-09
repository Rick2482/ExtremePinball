extends Panel

@onready var label: Label = $Label
@onready var continue_button: Button = $Button

func _on_button_pressed():
	visible = false
